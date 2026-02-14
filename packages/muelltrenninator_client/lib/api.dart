import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'l10n/app_localizations.dart';
import 'main.dart';

class ApiManager {
  ApiManager._();

  static final forceProduction = false;
  static Uri get baseUri => Uri.parse(
    forceProduction
        ? "https://muelltrenninator.con.bz/api"
        : (kDebugMode ? "http://localhost:33553/api" : "/api"),
  );
}

class AuthManager extends ChangeNotifier {
  AuthManager._();
  static final AuthManager _instance = AuthManager._();
  static AuthManager get instance => _instance;

  Future<void> initialize() async {
    await _instance.fetchAuthenticatedUser();
  }

  Future<void> fetchAuthenticatedUser({String? token}) async {
    final response = await fetch(
      http.Request("GET", Uri.parse("${ApiManager.baseUri}/users/whoami")),
      token: token,
    );

    final body = response?.body;
    if (response != null && response.statusCode == 200 && body != null) {
      username = jsonDecode(body)["username"] as String?;
      if (authToken == null) {
        prefs.setString("token", token ?? "");
      }
      notifyListeners();
    }
  }

  Future<void> logout() async {
    username = null;
    prefs.remove("token");
    notifyListeners();
  }

  String? username;
  String? get authToken => prefs.getString("token");
  final http.Client client = http.Client();

  bool _wasLastFetchNetworkError = false;
  bool get wasLastFetchNetworkError => _wasLastFetchNetworkError;

  Future<http.Response?> fetch(
    http.BaseRequest request, {
    String? token,
  }) async {
    request = fetchPrepare(request, token: token);

    http.Response response;
    try {
      final streamedResponse = await client
          .send(request)
          .timeout(Duration(seconds: 15));
      response = await http.Response.fromStream(streamedResponse).onError(
        (error, stackTrace) => Error.throwWithStackTrace(error!, stackTrace),
      );
    } catch (_) {
      _wasLastFetchNetworkError = true;
      return null;
    }
    _wasLastFetchNetworkError = false;

    if (response.statusCode == 401) await logout();
    return response;
  }

  http.BaseRequest fetchPrepare(http.BaseRequest request, {String? token}) {
    final effectiveToken = token ?? authToken;
    if (effectiveToken == null) return request;
    return request..headers["Authorization"] = "Token $effectiveToken";
  }
}

enum PredictionType {
  organic,
  hazardous,
  plastic,
  paper,
  residual;

  Color color(Brightness brightness) {
    switch (this) {
      case PredictionType.organic:
        return brightness == Brightness.light
            ? Colors.brown
            : Colors.brown[400]!;
      case PredictionType.hazardous:
        return brightness == Brightness.light
            ? Colors.redAccent
            : Colors.deepOrange[400]!;
      case PredictionType.plastic:
        return brightness == Brightness.light
            ? Colors.amber[600]!
            : Colors.amber[400]!;
      case PredictionType.paper:
        return brightness == Brightness.light
            ? Colors.lightBlue
            : Colors.lightBlue[400]!;
      case PredictionType.residual:
        return brightness == Brightness.light
            ? Colors.grey[800]!
            : Colors.blueGrey[600]!;
    }
  }

  String title(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicTitle;
      case PredictionType.hazardous:
        return appLocalizations.predictionTypeHazardousWasteTitle;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticTitle;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperTitle;
      case PredictionType.residual:
        return appLocalizations.predictionTypeResidualWasteTitle;
    }
  }

  String description(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicDescription;
      case PredictionType.hazardous:
        return appLocalizations.predictionTypeHazardousWasteDescription;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticDescription;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperDescription;
      case PredictionType.residual:
        return appLocalizations.predictionTypeResidualWasteDescription;
    }
  }

  String examples(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicExamples;
      case PredictionType.hazardous:
        return appLocalizations.predictionTypeHazardousWasteExamples;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticExamples;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperExamples;
      case PredictionType.residual:
        return appLocalizations.predictionTypeResidualWasteExamples;
    }
  }

  String negativeExamples(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicNegativeExamples;
      case PredictionType.hazardous:
        return appLocalizations.predictionTypeHazardousWasteNegativeExamples;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticNegativeExamples;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperNegativeExamples;
      case PredictionType.residual:
        return appLocalizations.predictionTypeResidualWasteNegativeExamples;
    }
  }

  Image image() => Image.asset("assets/images/$name.jpg", isAntiAlias: true);

  String get apiString {
    switch (this) {
      case PredictionType.organic:
        return "bio";
      case PredictionType.hazardous:
        return "elektroschrott";
      case PredictionType.plastic:
        return "gelber_sack";
      case PredictionType.paper:
        return "papier";
      case PredictionType.residual:
        return "restmuell";
    }
  }
}
