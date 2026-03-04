import 'dart:io';
import 'dart:math';

import 'package:muelltrenninator/generated/gitbaker.g.dart';
import 'package:shelf/shelf.dart';

String generateCode([int length = 8]) {
  String codeCharSpace = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final random = Random.secure();
  return List.generate(length, (index) {
    return codeCharSpace[random.nextInt(codeCharSpace.length)];
  }).join();
}

String? identifierFromRequest(Request request) {
  final xForwarded = request.headers["x-forwarded-for"]
      ?.split(",")
      .first
      .trim();
  if (xForwarded != null && xForwarded.isNotEmpty) return xForwarded;

  final forwarded = request.headers["Forwarded"]
      ?.split(";")
      .where((e) => e.trim().startsWith("for"))
      .firstOrNull
      ?.split("=")
      .last;
  if (forwarded != null && forwarded.isNotEmpty) return forwarded;

  final ip =
      (request.context["shelf.io.connection_info"] as HttpConnectionInfo?)
          ?.remoteAddress
          .address;
  return ip;
}

String? localeFromRequest(Request req) {
  final languages = req.headers["accept-language"]?.split(",");
  if (languages == null || languages.isEmpty) return null;

  languages.sort(
    (a, b) => (a.contains(";q=") ? double.parse(a.split(";q=")[1]) : 1)
        .compareTo(b.contains(";q=") ? double.parse(b.split(";q=")[1]) : 1),
  );
  return languages.last.split("-").first.toLowerCase();
}

String gitBakerWorkspaceFormat(List<WorkspaceEntry> entries) {
  if (entries.isEmpty ||
      (entries.length == 1 && entries[0].path.endsWith("gitbaker.g.dart"))) {
    return "clean";
  }
  final addedIndex = entries
      .whereType<WorkspaceEntryChange>()
      .where((e) => e.status.x == WorkspaceEntryStatusPart.added)
      .length;
  final addedWorking = entries
      .whereType<WorkspaceEntryChange>()
      .where((e) => e.status.y == WorkspaceEntryStatusPart.added)
      .length;
  final modifiedIndex = entries
      .whereType<WorkspaceEntryChange>()
      .where((e) => e.status.x == WorkspaceEntryStatusPart.modified)
      .length;
  final modifiedWorking = entries
      .whereType<WorkspaceEntryChange>()
      .where((e) => e.status.y == WorkspaceEntryStatusPart.modified)
      .length;
  final removedIndex = entries
      .whereType<WorkspaceEntryChange>()
      .where((e) => e.status.x == WorkspaceEntryStatusPart.deleted)
      .length;
  final removedWorking = entries
      .whereType<WorkspaceEntryChange>()
      .where((e) => e.status.y == WorkspaceEntryStatusPart.deleted)
      .length;
  final renamedCopied = entries.whereType<WorkspaceEntryRenameCopy>().length;
  final untracked = entries.whereType<WorkspaceEntryUntracked>().length;
  return [
    if (addedIndex > 0 || modifiedIndex > 0 || removedIndex > 0)
      "I${[if (addedIndex > 0) "+$addedIndex", if (modifiedIndex > 0) "\u00B1$modifiedIndex", if (removedIndex > 0) "\u2212$removedIndex"].join()}",
    if (addedWorking > 0 || modifiedWorking > 0 || removedWorking > 0)
      "W${[if (addedWorking > 0) "+$addedWorking", if (modifiedWorking > 0) "\u00B1$modifiedWorking", if (removedWorking > 0) "\u2212$removedWorking"].join()}",
    if (renamedCopied > 0) "R$renamedCopied",
    if (untracked > 0) "U$untracked",
  ].join(" ");
}
