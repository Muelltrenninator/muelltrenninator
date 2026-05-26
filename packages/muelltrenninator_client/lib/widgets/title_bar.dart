import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:muelltrenninator/generated/gitbaker.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';

class TitleBarTitle extends StatelessWidget {
  final GestureTapCallback? onTap;
  const TitleBarTitle({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icon.png",
              scale: devicePixelRatio,
              height: theme.iconTheme.size ?? 32,
              isAntiAlias: true,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(width: 8),
            Builder(
              builder: (context) => Text(
                "Mülltrenninator",
                style: TextTheme.of(context).headlineMedium!.stylizedInterface
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  const TitleBar({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/icon.png"), context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: TitleBarTitle(
        // onTap: () => context.navigateTo(MainRoute())
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      actions: [
        Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme.of(context)
                .apply(fontFamily: "GoogleSansFlex")
                .copyWith(
                  bodyMedium: TextTheme.of(context).bodyMedium!.stylizedDialog,
                  bodySmall: TextTheme.of(context).bodySmall!.stylizedDialog,
                  bodyLarge: TextTheme.of(context).bodyLarge!.stylizedDialog,
                  headlineSmall: TextTheme.of(context)
                      .headlineSmall!
                      .stylizedInterface
                      .copyWith(fontWeight: FontWeight.w600),
                  labelLarge: TextTheme.of(
                    context,
                  ).labelLarge!.stylizedInterface,
                ),
          ),
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () => showAboutDialog(
                context: context,
                applicationName: "Mülltrenninator",
                applicationVersion:
                    "${GitBaker.currentBranch.name}"
                            "@${GitBaker.currentBranch.commits.last.hashAbbreviated} "
                            "${GitBaker.workspace.isNotEmpty ? "(${gitBakerWorkspaceFormat(GitBaker.workspace)})" : ""}"
                        .trim(),
                applicationIcon: Image.asset(
                  "assets/icon.png",
                  height: 84,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                ),
                applicationLegalese: "© 2025–2026 JHubi1. All rights reserved.",
                children: [
                  SizedBox(height: 24),
                  ListTile(
                    onTap: () => launchUrl(
                      Uri.parse("https://github.com/Muelltrenninator"),
                    ),
                    leading: Icon(Icons.call_made_rounded),
                    title: Text(AppLocalizations.of(context).aboutAppLearnMore),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    onTap: () =>
                        context.pushRoute(MarkdownDialogTermsOfServiceRoute()),
                    leading: Icon(Icons.description_rounded),
                    title: Text(AppLocalizations.of(context).termsOfService),
                  ),
                  ListTile(
                    onTap: () =>
                        context.pushRoute(MarkdownDialogPrivacyPolicyRoute()),
                    leading: Icon(Icons.privacy_tip_rounded),
                    title: Text(AppLocalizations.of(context).privacyPolicy),
                  ),
                  ListTile(
                    onTap: () =>
                        context.pushRoute(MarkdownDialogImprintRoute()),
                    leading: Icon(Icons.gavel_rounded),
                    title: Text(AppLocalizations.of(context).imprint),
                  ),
                ],
              ),
              icon: Icon(Icons.question_mark_rounded),
            ),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

String initialsFromUsername(String? username) {
  if (username == null || username.isEmpty) return "";
  final wordMatches = RegExp(r"[A-Z]?[a-z]+").allMatches(username);
  if (wordMatches.isNotEmpty) {
    final initials = wordMatches
        .take(2)
        .map((m) => username[m.start].toUpperCase())
        .join();
    if (initials.isNotEmpty) return initials;
  }
  final caps = RegExp(
    r"[A-Z]",
  ).allMatches(username).map((m) => username[m.start]).toList();
  if (caps.isNotEmpty) return caps.take(2).join().toUpperCase();
  return username[0].toUpperCase();
}

bool validateEmail(String email) => RegExp(
  r"""^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$""",
).hasMatch(email);

String gitBakerWorkspaceFormat(List<WorkspaceEntry> entries) {
  if (entries.isEmpty ||
      (entries.length == 1 && entries[0].path.endsWith("gitbaker.g.dart"))) {
    return "Clean";
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
