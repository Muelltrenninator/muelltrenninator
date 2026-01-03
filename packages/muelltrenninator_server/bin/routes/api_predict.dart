import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:shelf_router/shelf_router.dart';

import '../helpers.dart';
import 'api.dart';

void define(Router router) {
  router
    ..get(
      "/users/whoami", // MARK: [GET] /users/whoami
      apiAuthWall((req, username) {
        return Response.ok(
          jsonEncode({"username": username}),
          headers: {"Content-Type": "application/json"},
        );
      }),
    )
    ..post(
      "/predict", // MARK: [POST] /predict
      apiAuthWall((req, _) async {
        if (req.headers["content-type"] == null ||
            !req.headers["content-type"]!.startsWith("multipart/")) {
          return Response.badRequest(
            body: jsonEncode({
              "error": "Content-Type must be multipart/form-data",
            }),
            headers: {"Content-Type": "application/json"},
          );
        }

        MultipartRequest? data;
        try {
          data = req.multipart();
        } catch (_) {}
        if (data == null) {
          return Response.badRequest(
            body: jsonEncode({"error": "Invalid multipart request"}),
            headers: {"Content-Type": "application/json"},
          );
        }

        late final Multipart part;
        String name;
        http.MediaType mime;
        try {
          part = (await data.parts.toList()).first;
          name =
              part.headers["content-disposition"]
                  ?.split(";")
                  .firstWhere(
                    (e) => e.trim().startsWith("name="),
                    orElse: () => 'name="file"',
                  )
                  .split("=")
                  .last
                  .replaceAll('"', '') ??
              "file.dat";
          mime = http.MediaType.parse(part.headers["content-type"]!);
        } catch (e) {
          return Response.badRequest(
            body: jsonEncode({"error": "Invalid multipart data: $e"}),
            headers: {"Content-Type": "application/json"},
          );
        }

        final uploadId = generateCode(11);
        final upload = await http.Response.fromStream(
          await (http.MultipartRequest(
                  "POST",
                  Uri.parse(
                    "$modelBaseUri/gradio_api/upload?upload_id=$uploadId",
                  ),
                )
                ..files.add(
                  http.MultipartFile.fromBytes(
                    "files",
                    await part.readBytes(),
                    filename: name,
                    contentType: mime,
                  ),
                ))
              .send(),
        );

        final eventId = jsonDecode(
          (await http.post(
            Uri.parse("$modelBaseUri/gradio_api/call/predict"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "data": [
                {
                  "path": jsonDecode(upload.body)[0],
                  "meta": {"_type": "gradio.FileData"},
                },
              ],
            }),
          )).body,
        )["event_id"];
        final prediction = await http.get(
          Uri.parse("$modelBaseUri/gradio_api/call/predict/$eventId"),
        );

        if (prediction.body.split("event: ").last.startsWith("error")) {
          return Response(
            422,
            body: jsonEncode({"error": "Prediction failed by model backend."}),
          );
        }
        return Response.ok(
          jsonEncode({
            "prediction": jsonDecode(
              jsonDecode(prediction.body.split("data: ").last)[0],
            ),
          }),
          headers: {"Content-Type": "application/json"},
        );
      }),
    );
}
