// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:muelltrenninator_client/main.dart' as _i3;
import 'package:muelltrenninator_client/screens/error.dart' as _i1;
import 'package:muelltrenninator_client/screens/login.dart' as _i2;
import 'package:muelltrenninator_client/screens/terms.dart' as _i4;
import 'package:muelltrenninator_client/screens/upload.dart' as _i5;

/// generated route for
/// [_i1.ErrorScreen]
class ErrorRoute extends _i6.PageRouteInfo<void> {
  const ErrorRoute({List<_i6.PageRouteInfo>? children})
    : super(ErrorRoute.name, initialChildren: children);

  static const String name = 'ErrorRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.ErrorScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.MainScreen]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainScreen();
    },
  );
}

/// generated route for
/// [_i4.MarkdownDialogImprintPage]
class MarkdownDialogImprintRoute extends _i6.PageRouteInfo<void> {
  const MarkdownDialogImprintRoute({List<_i6.PageRouteInfo>? children})
    : super(MarkdownDialogImprintRoute.name, initialChildren: children);

  static const String name = 'MarkdownDialogImprintRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.MarkdownDialogImprintPage();
    },
  );
}

/// generated route for
/// [_i4.MarkdownDialogPrivacyPolicyPage]
class MarkdownDialogPrivacyPolicyRoute extends _i6.PageRouteInfo<void> {
  const MarkdownDialogPrivacyPolicyRoute({List<_i6.PageRouteInfo>? children})
    : super(MarkdownDialogPrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'MarkdownDialogPrivacyPolicyRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.MarkdownDialogPrivacyPolicyPage();
    },
  );
}

/// generated route for
/// [_i4.MarkdownDialogTermsOfServicePage]
class MarkdownDialogTermsOfServiceRoute extends _i6.PageRouteInfo<void> {
  const MarkdownDialogTermsOfServiceRoute({List<_i6.PageRouteInfo>? children})
    : super(MarkdownDialogTermsOfServiceRoute.name, initialChildren: children);

  static const String name = 'MarkdownDialogTermsOfServiceRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.MarkdownDialogTermsOfServicePage();
    },
  );
}

/// generated route for
/// [_i5.PredictionScreen]
class PredictionRoute extends _i6.PageRouteInfo<PredictionRouteArgs> {
  PredictionRoute({
    _i7.Key? key,
    _i8.Future<_i9.Uint8List>? image,
    String? prediction,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         PredictionRoute.name,
         args: PredictionRouteArgs(
           key: key,
           image: image,
           prediction: prediction,
         ),
         rawQueryParams: {'p': prediction},
         initialChildren: children,
       );

  static const String name = 'PredictionRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<PredictionRouteArgs>(
        orElse: () =>
            PredictionRouteArgs(prediction: queryParams.optString('p')),
      );
      return _i5.PredictionScreen(
        key: args.key,
        image: args.image,
        prediction: args.prediction,
      );
    },
  );
}

class PredictionRouteArgs {
  const PredictionRouteArgs({this.key, this.image, this.prediction});

  final _i7.Key? key;

  final _i8.Future<_i9.Uint8List>? image;

  final String? prediction;

  @override
  String toString() {
    return 'PredictionRouteArgs{key: $key, image: $image, prediction: $prediction}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PredictionRouteArgs) return false;
    return key == other.key &&
        image == other.image &&
        prediction == other.prediction;
  }

  @override
  int get hashCode => key.hashCode ^ image.hashCode ^ prediction.hashCode;
}

/// generated route for
/// [_i5.UploadPage]
class UploadRoute extends _i6.PageRouteInfo<void> {
  const UploadRoute({List<_i6.PageRouteInfo>? children})
    : super(UploadRoute.name, initialChildren: children);

  static const String name = 'UploadRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.UploadPage();
    },
  );
}
