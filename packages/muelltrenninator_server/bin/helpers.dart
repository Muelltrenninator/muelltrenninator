import 'dart:io';
import 'dart:math';

import 'package:shelf/shelf.dart';

String _codeCharSpace = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String generateCode([int length = 8]) {
  final random = Random.secure();
  return List.generate(length, (index) {
    return _codeCharSpace[random.nextInt(_codeCharSpace.length)];
  }).join();
}

String? identifierFromRequest(Request request) {
  final xForwarded = request.headers["x-forwarded-for"]
      ?.split(",")
      .first
      .trim();
  final forwarded = request.headers["Forwarded"]
      ?.split(";")
      .where((e) => e.trim().startsWith("for"))
      .firstOrNull
      ?.split("=")
      .last;
  final ip =
      (request.context["shelf.io.connection_info"] as HttpConnectionInfo?)
          ?.remoteAddress
          .address;
  return xForwarded ?? forwarded ?? ip;
}
