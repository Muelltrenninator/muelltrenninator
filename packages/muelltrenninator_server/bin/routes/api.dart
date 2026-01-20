import 'dart:async';
import 'dart:convert';

// possibility of reenabling of authentication in the future
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_limiter/shelf_limiter.dart';
import 'package:shelf_router/shelf_router.dart';

import '../helpers.dart';
import '../server.dart';
import 'api_predict.dart' as api_predict;

Uri get modelBaseUri =>
    devEnv ? Uri.parse("http://s001:7861") : Uri.parse("http://model:7860");

final apiRouter = Router(
  notFoundHandler: (request) => Response.notFound(
    jsonEncode({"error": "Unknown endpoint"}),
    headers: {"Content-Type": "application/json"},
  ),
);
Handler get apiPipeline => Pipeline()
    .addMiddleware((innerHandler) {
      final limiter = shelfLimiter(
        RateLimiterOptions(
          maxRequests: 5,
          windowSize: Duration(seconds: 10),
          clientIdentifierExtractor: (request) =>
              identifierFromRequest(request)!,
          onRateLimitExceeded: (request) {
            t.warn(
              "Rate limit exceeded for: ${identifierFromRequest(request)} (unauthenticated)",
            );
            return Response(
              429,
              body: jsonEncode({
                "error": "Too many requests, please try again later",
              }),
              headers: {"Content-Type": "application/json"},
            );
          },
        ),
      );
      return (request) async {
        if (identifierFromRequest(request) == null) {
          return Response(
            400,
            body: jsonEncode({
              "error": "Cannot identify client for rate limiting",
            }),
            headers: {"Content-Type": "application/json"},
          );
        }

        final response = await innerHandler(request);
        if (response.statusCode == 401) {
          return limiter.call((_) => response).call(request);
        } else {
          return response;
        }
      };
    })
    .addHandler(apiRouter.call);

void defineApiRouter() {
  api_predict.define(apiRouter);
}

// MARK: Authentication

Future<Object?> _apiAuthInternal(Request req) async {
  // var token = req.headers["authorization"];
  // if ((!(token?.startsWith("Token ") ?? false) || token!.length != (6 + 8))) {
  //   return Response.unauthorized(
  //     jsonEncode({"error": "Invalid or missing authorization token"}),
  //     headers: {"Content-Type": "application/json"},
  //   );
  // }
  // token = token.substring(6);

  // final authVerify = await http.get(
  //   Uri.parse("https://datly.con.bz/api/users/whoami"),
  //   headers: {"Authorization": "Token $token"},
  // );
  // if (authVerify.statusCode != 200) {
  //   return Response.unauthorized(
  //     jsonEncode({"error": "Unknown authorization token"}),
  //     headers: {"Content-Type": "application/json"},
  //   );
  // }

  // return jsonDecode(authVerify.body)["username"];
  return null;
}

Future<Response?> apiAuth(Request req) async {
  final result = await _apiAuthInternal(req);
  if (result is Response) return result;
  return null;
}

Future<Response> Function(Request req) apiAuthWall(
  Function(Request req, String? username) handler,
) => (Request req) async {
  final result = await _apiAuthInternal(req);
  if (result is Response) return result;
  return handler.call(req, result as String?);
};
