import 'dart:io';
import 'dart:typed_data';

import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:tracer/tracer.dart';

import 'routes/api.dart';

final t = Tracer(
  "muelltrenninator_server",
  logLevel: TracerLevel.debug,
  indentation: false,
  forceUtc: true,
  handlers: [TracerConsoleHandler(useStderr: true)],
);
const devEnv = !bool.fromEnvironment("dart.vm.product");

late final HttpServer server;
final _router = Router()
  ..mount("/api", apiPipeline)
  ..get("/legal/privacy", legalHandler)
  ..get("/legal/terms", legalHandler)
  ..mount("/", fileHandler);

Future<Response> fileHandler(Request req) async {
  final path = req.url.path == ""
      ? "index.html"
      : req.url.path.replaceAll("..", "");

  var file = File("public/$path");
  if (!(await file.exists())) file = File("public/index.html");

  late final Object contents;
  if (file.path == "public/index.html") {
    contents = (await file.readAsString()).replaceAll(
      "{{CANONICAL}}",
      "https://muelltrenninator.con.bz",
    );
  } else {
    contents = await file.readAsBytes();
  }

  final headers = {
    HttpHeaders.contentTypeHeader:
        lookupMimeType(file.path) ?? "application/octet-stream",

    // https://docs.flutter.dev/platform-integration/web/wasm#serve-the-built-output-with-an-http-server
    "Cross-Origin-Embedder-Policy": "require-corp",
    "Cross-Origin-Opener-Policy": "same-origin",
  };
  final response = Response.ok(contents, headers: headers);
  return req.method == "HEAD" ? response.change(body: null) : response;
}

Future<Response> legalHandler(Request req) async {
  final path = req.url.path.replaceAll("..", "").split("/").last;
  final file = File("legal/$path.md");
  if (!(await file.exists())) return Response.notFound("Document not found");

  final contents = await file.readAsString();
  final headers = {
    HttpHeaders.contentTypeHeader: "text/markdown; charset=utf-8",
  };
  final response = Response.ok(contents, headers: headers);
  return req.method == "HEAD" ? response.change(body: null) : response;
}

bool processingShutdown = false;
void shutdown([String signal = "Signal"]) async {
  if (processingShutdown) return;
  processingShutdown = true;
  t.info("Received $signal -> Shutting down");

  try {
    await server.close();
    t.debug("Server closed successfully");
  } catch (e) {
    t.error("Error closing server: $e");
  }

  t.info("Shutdown complete, bye 👋");
  exit(0);
}

void main(List<String> args) async {
  for (var i in [ProcessSignal.sigint, ProcessSignal.sigterm]) {
    i.watch().listen((e) => shutdown(e.name), onError: (_) {});
  }

  Directory.current = Platform.script.resolve(".").toFilePath();
  defineApiRouter();

  final handler = Pipeline()
      .addMiddleware(
        logRequests(
          logger: (message, isError) {
            String format(String message, [bool isError = false]) {
              var parts = message.split(RegExp(r" |\t"))
                ..removeWhere((part) => part.trim().isEmpty);
              if (isError) {
                parts.removeAt(0);
                parts.insert(3, "[500]");
              }
              return "${parts[2]} ${parts[3].replaceAll(RegExp(r"\[|\]"), "")} - ${parts[4]}";
            }

            if (isError) {
              var output = message.split("\n");
              var log = output.removeAt(0);
              t.error(
                format(log, true),
                error: output.removeAt(0),
                stack: StackTrace.fromString(output.join("\n")),
              );
            } else {
              var formatted = format(message);
              ((formatted.split(" ")[1].toString().startsWith("5"))
                      ? t.warn
                      : t.debug)
                  .call(formatted);
            }
          },
        ),
      )
      .addHandler(_router.call);

  final ip = InternetAddress.anyIPv4;
  final port = 33553;
  server = await serve(
    handler,
    ip,
    port,
    poweredByHeader: "Muelltrenninator Server",
  );

  t.info("Server listening on port ${server.port}");
}
