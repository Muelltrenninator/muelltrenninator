// GitBaker v0.1.2 <https://pub.dev/packages/gitbaker>

// This is an automatically generated file by GitBaker. Do not modify manually.
// To regenerate this file, please rerun the command 'dart run gitbaker'

/// Generated Git history and metadata for the current Git repository.
///
/// See <https://pub.dev/packages/gitbaker> for more information. To update or
/// regenerate this file, run `dart run gitbaker` somewhere in this repository.
///
/// Last generated: 2026-03-17T21:20:00
library;

enum RemoteType { fetch, push, unknown }

/// A class representing a remote repository or connection.
final class Remote {
  final String name;
  final RemoteType type;
  final Uri uri;

  const Remote._({required this.name, required this.type, required this.uri});

  Map<String, Object?> toJson() => {
    "name": name,
    "type": type.name,
    "uri": uri.toString(),
  };
}

/// A class representing a contributor to the repository.
///
/// Each user is uniquely identified by their email address. Multiple users
/// may share the same name, but not the same email.
final class User {
  final String name;
  final String email;

  const User._({required this.name, required this.email});

  List<Commit> get contributions => List.unmodifiable(
    GitBaker.commits.where((c) => c.author == this).toList(),
  );

  Map<String, Object?> toJson() => {"name": name, "email": email};
}

/// A class representing a Git branch.
final class Branch {
  final String name;

  /// The number of commits in this branch, following only the first parent.
  ///
  /// This value can be used to determine the relative age of branches, but
  /// should not be used to determine the absolute number of commits. For that,
  /// use [commits].length instead.
  final int revision;

  final int ahead;
  final int behind;

  final List<String> _commits;
  List<Commit> get commits => List.unmodifiable(
    _commits
        .map((h) => GitBaker.commits.singleWhere((c) => c.hash == h))
        .toList(),
  );

  bool get isCurrent => this == GitBaker.currentBranch;
  bool get isDefault => this == GitBaker.defaultBranch;

  const Branch._({
    required this.name,
    required this.revision,
    required this.ahead,
    required this.behind,
    required List<String> commits,
  }) : _commits = commits;

  Map<String, Object?> toJson() => {
    "name": name,
    "revision": revision,
    "commits": _commits.toList(),
  };
}

/// A class representing a Git tag.
///
/// You may use the [commit] property's message as a description of the tag
/// next to its name.
final class Tag {
  final String name;

  final String _commit;
  Commit get commit => GitBaker.commits.singleWhere((c) => c.hash == _commit);

  const Tag._({required this.name, required String commit}) : _commit = commit;

  Map<String, Object?> toJson() => {"name": name, "commit": _commit};
}

/// A class representing a single commit in the Git repository.
final class Commit {
  final String hash;
  final String hashAbbreviated;

  final String message;
  final DateTime date;

  /// Whether the commit has been signed.
  ///
  /// ***Careful:*** Not whether the signature is valid, only whether it
  /// exists. Git is unable to verify signatures without access to the public
  /// key of the signer, which is not stored in the repository.
  final bool signed;

  /// The branches that contain this commit.
  ///
  /// This may be empty if the commit is not present in any branch (e.g. if it
  /// is only present in tags or is an orphaned commit).
  List<Branch> get presentIn => List.unmodifiable(
    GitBaker.branches.where((b) => b.commits.contains(this)).toList(),
  );

  final String _author;
  User get author => GitBaker.members.singleWhere((e) => e.email == _author);

  final String _committer;
  User get committer =>
      GitBaker.members.singleWhere((e) => e.email == _committer);

  const Commit._(
    this.hash, {
    required this.hashAbbreviated,
    required this.message,
    required this.date,
    required this.signed,
    required String author,
    required String committer,
  }) : _author = author,
       _committer = committer;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Commit && other.hash == hash);
  @override
  int get hashCode => hash.hashCode;

  Map<String, Object?> toJson() => {
    "hash": hash,
    "hashAbbreviated": hashAbbreviated,
    "message": message,
    "date": date.toIso8601String(),
    "signed": signed,
    "author": _author,
    "committer": _committer,
  };
}

/// Represents the status of a working tree entry.
enum WorkspaceEntryStatusPart {
  unmodified,
  modified("M"),
  fileTypeChanged("T"),
  added("A"),
  deleted("D"),
  renamed("R"),
  copied("C"),
  updatedButUnmerged("U");

  final String letter;
  const WorkspaceEntryStatusPart([this.letter = "."]);

  factory WorkspaceEntryStatusPart._fromLetter(String letter) {
    return WorkspaceEntryStatusPart.values.firstWhere(
      (e) => e.letter == letter,
      orElse: () => WorkspaceEntryStatusPart.unmodified,
    );
  }
}

/// Represents the combined status of a working tree entry.
///
/// A status is always a combination of two [WorkspaceEntryStatusPart]s, one
/// for the index status (X) and one for the working tree status (Y).
///
/// https://git-scm.com/docs/git-status#_output
final class WorkspaceEntryStatus {
  /// The status of the entry in the index.
  ///
  /// The index is the staging area, where changes are prepared for the next
  /// commit. Meaning that if this has a value, there are changes to this file
  /// that are not yet committed, but already staged.
  final WorkspaceEntryStatusPart x;

  /// The status of the entry in the working tree.
  ///
  /// The working tree is the current state of the files in the repository.
  /// Meaning that if this has a value, there are changes to this file that are
  /// not yet committed, and not yet staged.
  final WorkspaceEntryStatusPart y;

  WorkspaceEntryStatus._fromLetters(String x, String y)
    : x = WorkspaceEntryStatusPart._fromLetter(x),
      y = WorkspaceEntryStatusPart._fromLetter(y);

  Map<String, Object?> toJson() => {"x": x.name, "y": y.name};
}

/// Represents the state of a submodule in the working tree.
final class WorkspaceEntrySubmoduleState {
  final bool commitChanged;
  final bool hasTrackedChanges;
  final bool hasUntrackedChanges;

  const WorkspaceEntrySubmoduleState._({
    required this.commitChanged,
    required this.hasTrackedChanges,
    required this.hasUntrackedChanges,
  });

  Map<String, Object?> toJson() => {
    "commitChanged": commitChanged,
    "hasTrackedChanges": hasTrackedChanges,
    "hasUntrackedChanges": hasUntrackedChanges,
  };
}

/// A class representing a single entry in the working tree of the repository.
///
/// You may use the subclasses to determine the type of entry:
/// - [WorkspaceEntryChange] for changed entries
/// - [WorkspaceEntryRenameCopy] for renamed or copied entries
/// - [WorkspaceEntryUntracked] for untracked entries
/// - [WorkspaceEntryIgnored] for ignored entries
///
/// https://git-scm.com/docs/git-status#_porcelain_format_version_2
abstract final class WorkspaceEntry {
  /// Path relative to the repository root of this entry.
  final String path;

  final bool _isUntracked;
  final bool _isIgnored;
  const WorkspaceEntry._(this.path) : _isUntracked = false, _isIgnored = false;
  const WorkspaceEntry._untracked(this.path)
    : _isUntracked = true,
      _isIgnored = false;
  const WorkspaceEntry._ignored(this.path)
    : _isUntracked = false,
      _isIgnored = true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceEntry &&
          other.path == path &&
          other._isUntracked == _isUntracked &&
          other._isIgnored == _isIgnored);
  @override
  int get hashCode => Object.hash(path, _isUntracked, _isIgnored);

  Map<String, Object?> toJson() => {
    "type": _isUntracked
        ? "untracked"
        : (_isIgnored ? "ignored" : throw UnimplementedError()),
    "path": path,
  };
}

/// A class representing a changed entry in the working tree.
final class WorkspaceEntryChange extends WorkspaceEntry {
  final WorkspaceEntryStatus status;
  final WorkspaceEntrySubmoduleState submoduleState;

  const WorkspaceEntryChange._(
    super.path, {
    required this.status,
    required this.submoduleState,
  }) : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceEntryChange &&
          other.path == path &&
          other.status == status &&
          other.submoduleState == submoduleState);
  @override
  int get hashCode => Object.hash(path, status, submoduleState);

  @override
  Map<String, Object?> toJson() => {
    "type": "change",
    "path": path,
    "status": status.toJson(),
    "submoduleState": submoduleState.toJson(),
  };
}

/// A class representing a renamed or copied entry in the working tree.
final class WorkspaceEntryRenameCopy extends WorkspaceEntryChange {
  final double score;
  final String oldPath;

  const WorkspaceEntryRenameCopy._(
    super.path, {
    required super.status,
    required super.submoduleState,
    required this.score,
    required this.oldPath,
  }) : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceEntryRenameCopy &&
          other.path == path &&
          other.score == score &&
          other.oldPath == oldPath);
  @override
  int get hashCode => Object.hash(path, score, oldPath);

  @override
  Map<String, Object?> toJson() => {
    "type": "rename/copy",
    "path": path,
    "status": status.toJson(),
    "submoduleState": submoduleState.toJson(),
    "score": score,
    "oldPath": oldPath,
  };
}

/// A class representing an untracked entry in the working tree.
final class WorkspaceEntryUntracked extends WorkspaceEntry {
  const WorkspaceEntryUntracked._(super.path) : super._untracked();
}

/// A class representing an ignored entry in the working tree.
final class WorkspaceEntryIgnored extends WorkspaceEntry {
  const WorkspaceEntryIgnored._(super.path) : super._ignored();
}

final class GitBaker {
  GitBaker._();

  // possibility of null if no description is set
  // ignore: unnecessary_nullable_for_final_variable_declarations
  static const String? description =
      "System for interacting with the “Mülltrenninator” project and a proxy for the AI worker.";

  /// The most likely remote to be used for fetching and pushing.
  ///
  /// This is determined by first looking for a remote named "origin" with type
  /// [RemoteType.fetch]. If no such remote exists, the first remote with type
  /// [RemoteType.fetch] is used, regardless of its name. If no such remote
  /// exists, the first remote in [remotes] is used.
  static Remote get remote => remotes.firstWhere(
    (r) => r.name == "origin" && r.type == RemoteType.fetch,
    orElse: () => remotes.firstWhere(
      (r) => r.type == RemoteType.fetch,
      orElse: () => remotes.first,
    ),
  );

  /// All remotes configured for this repository.
  ///
  /// This includes remotes for fetching and pushing, as well as any other types
  /// of remotes that may be configured.
  ///
  /// Note that multiple remotes may have the same [name] and [uri], but
  /// different [type]s. For example, a remote may be configured for both
  /// fetching and pushing.
  static final List<Remote> remotes = List.unmodifiable([
    Remote._(
      name: "origin",
      type: RemoteType.fetch,
      uri: Uri.parse(
        "https://github.com/Muelltrenninator/muelltrenninator.git",
      ),
    ),
    Remote._(
      name: "origin",
      type: RemoteType.push,
      uri: Uri.parse(
        "https://github.com/Muelltrenninator/muelltrenninator.git",
      ),
    ),
  ]);

  /// All members to this repository.
  ///
  /// Each user is uniquely identified by their email address. Multiple users
  /// may share the same name, but not the same email.
  static const List<User> members = [
    User._(name: "JHubi1", email: "me@jhubi1.com"),
  ];

  /// The default branch of the repository, usually "main" or "master".
  static final Branch defaultBranch = branches.singleWhere(
    (e) => e.name == "main",
  );

  /// The currently checked out branch of the repository.
  static final Branch currentBranch = branches.singleWhere(
    (e) => e.name == "main",
  );

  /// List of uncommitted changes in the working tree of the repository.
  static final List<WorkspaceEntry> workspace = List.unmodifiable([
    WorkspaceEntryChange._(
      "lib/generated/gitbaker.g.dart",
      status: WorkspaceEntryStatus._fromLetters(".", "M"),
      submoduleState: WorkspaceEntrySubmoduleState._(
        commitChanged: false,
        hasTrackedChanges: false,
        hasUntrackedChanges: false,
      ),
    ),
  ]);

  /// All branches in the repository.
  ///
  /// If the configuration sets the list `branches`, only branches matching any
  /// of the provided regular expressions are included. If it is empty or not
  /// set, all branches are included.
  static const List<Branch> branches = [
    Branch._(
      name: "main",
      revision: 17,
      ahead: 0,
      behind: 0,
      commits: [
        "22f43fc620924e6cef9c6a214251d942e6f0747d",
        "744a69cbc94f3258dfb8bf167efeb0a508292913",
        "d4880ee4fc7604b8cf51a2036c7a05d1b6eee561",
        "da068533943dae2ca4facfa838edf7fda6dcdff4",
        "0d61b0116e643df07590223fbe65eb9316bad498",
        "df4a70ca37c8b6923eb8fa2d8230760f1e6dc1c5",
        "535f37c9ebdd5e961c23c0b43c577b95c5a71339",
        "18a27f223e5ece3d5dedaedc259e914cc3baf0b7",
        "b4b36f8d02a62eb587c48b7b116b9b31e9233170",
        "0c8c4a545571e17b41a4261f5d1512c7967df6a5",
        "b03844282f1a2722211a263bb852475e550a0ddd",
        "e4670bec7252dd44f0199bc396f173c04393e63b",
        "c8e6274b331381a18d8c290686b044cf7a7a3104",
        "35a3322143f5e0ed185d577b93e42e6f6b7ee7f1",
        "0adf67f0012c2173cff6f26ec9392730584f8afc",
        "3a2c815a16660f64e2706947c6fc23f5438eb0db",
        "15d01c539f7908d3fd4409f37ba9185dd5e80bcd",
      ],
    ),
  ];

  /// All tags in the repository.
  ///
  /// [Tag.commit.message] may be used as a description of a tag.
  ///
  /// Note that this won't get the release notes of Git hosting services like
  /// GitHub or GitLab, but only the tag name.
  static const List<Tag> tags = [];

  /// All commits in the repository, ordered from oldest to newest.
  static final List<Commit> commits = List.unmodifiable([
    Commit._(
      "22f43fc620924e6cef9c6a214251d942e6f0747d",
      hashAbbreviated: "22f43fc",
      message: "Initial commit",
      date: DateTime.parse("2026-01-02T20:23:32.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "744a69cbc94f3258dfb8bf167efeb0a508292913",
      hashAbbreviated: "744a69c",
      message: "Everything.",
      date: DateTime.parse("2026-01-03T01:39:15.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "d4880ee4fc7604b8cf51a2036c7a05d1b6eee561",
      hashAbbreviated: "d4880ee",
      message: "Update localization, UI, and server helpers",
      date: DateTime.parse("2026-01-03T19:57:52.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "da068533943dae2ca4facfa838edf7fda6dcdff4",
      hashAbbreviated: "da06853",
      message: "Adapted to new model server output",
      date: DateTime.parse("2026-01-03T22:38:44.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "0d61b0116e643df07590223fbe65eb9316bad498",
      hashAbbreviated: "0d61b01",
      message: "Result display adjustments, model safeguards",
      date: DateTime.parse("2026-01-04T23:30:06.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "df4a70ca37c8b6923eb8fa2d8230760f1e6dc1c5",
      hashAbbreviated: "df4a70c",
      message: "Algorithm adjustments, responsiveness",
      date: DateTime.parse("2026-01-05T16:10:49.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "535f37c9ebdd5e961c23c0b43c577b95c5a71339",
      hashAbbreviated: "535f37c",
      message: "Various algorithm changes",
      date: DateTime.parse("2026-01-10T22:33:36.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "18a27f223e5ece3d5dedaedc259e914cc3baf0b7",
      hashAbbreviated: "18a27f2",
      message: "Branding",
      date: DateTime.parse("2026-01-19T14:42:32.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "b4b36f8d02a62eb587c48b7b116b9b31e9233170",
      hashAbbreviated: "b4b36f8",
      message: "Icon adjustments",
      date: DateTime.parse("2026-01-19T15:09:44.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "0c8c4a545571e17b41a4261f5d1512c7967df6a5",
      hashAbbreviated: "0c8c4a5",
      message: "Bigger logo in UI",
      date: DateTime.parse("2026-01-19T15:28:04.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "b03844282f1a2722211a263bb852475e550a0ddd",
      hashAbbreviated: "b038442",
      message: "Disable auth",
      date: DateTime.parse("2026-01-20T06:27:00.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "e4670bec7252dd44f0199bc396f173c04393e63b",
      hashAbbreviated: "e4670be",
      message: "`isTrash` flag, updated predictions, issues fixed",
      date: DateTime.parse("2026-01-26T07:33:33.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "c8e6274b331381a18d8c290686b044cf7a7a3104",
      hashAbbreviated: "c8e6274",
      message: "Immersive mode fullscreen",
      date: DateTime.parse("2026-01-26T07:53:41.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "35a3322143f5e0ed185d577b93e42e6f6b7ee7f1",
      hashAbbreviated: "35a3322",
      message: "\"Electronic\"->\"Hazardous\" waste, bin colors",
      date: DateTime.parse("2026-02-14T16:42:32.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "0adf67f0012c2173cff6f26ec9392730584f8afc",
      hashAbbreviated: "0adf67f",
      message: "Imprint, small improvements",
      date: DateTime.parse("2026-03-04T21:27:11.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "3a2c815a16660f64e2706947c6fc23f5438eb0db",
      hashAbbreviated: "3a2c815",
      message: "Troubleshooting on camera issue, legal hotlinks",
      date: DateTime.parse("2026-03-08T14:16:21.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
    Commit._(
      "15d01c539f7908d3fd4409f37ba9185dd5e80bcd",
      hashAbbreviated: "15d01c5",
      message: "Web improvements",
      date: DateTime.parse("2026-03-17T20:19:41.000Z"),
      signed: true,
      author: "me@jhubi1.com",
      committer: "me@jhubi1.com",
    ),
  ]);

  static Map<String, Object?> toJson() => {
    "description": description,
    "remote": remote.toJson(),
    "remotes": remotes.map((r) => r.toJson()).toList(),
    "members": members.map((m) => m.toJson()).toList(),
    "defaultBranch": defaultBranch.name,
    "currentBranch": currentBranch.name,
    "workspace": workspace.map((e) => e.toJson()).toList(),
    "branches": branches.map((b) => b.toJson()).toList(),
    "tags": tags.map((t) => t.toJson()).toList(),
    "commits": commits.map((c) => c.toJson()).toList(),
  };
}
