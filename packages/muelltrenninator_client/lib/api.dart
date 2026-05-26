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
            ? Colors.yellow[800]!
            : Colors.amber[400]!;
      case PredictionType.paper:
        return brightness == Brightness.light
            ? Colors.blueAccent
            : Colors.lightBlue[400]!;
      case PredictionType.residual:
        return brightness == Brightness.light
            ? Colors.grey[800]!
            : Colors.blueGrey[400]!;
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

  String shortDescription(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicShortDescription;
      case PredictionType.hazardous:
        return appLocalizations.predictionTypeHazardousWasteShortDescription;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticShortDescription;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperShortDescription;
      case PredictionType.residual:
        return appLocalizations.predictionTypeResidualWasteShortDescription;
    }
  }

  String positiveExamples(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicPositiveExamples;
      case PredictionType.hazardous:
        return appLocalizations.predictionTypeHazardousWastePositiveExamples;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticPositiveExamples;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperPositiveExamples;
      case PredictionType.residual:
        return appLocalizations.predictionTypeResidualWastePositiveExamples;
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

  String? note(AppLocalizations appLocalizations) {
    final v = switch (this) {
      PredictionType.organic => appLocalizations.predictionTypeOrganicNote,
      PredictionType.hazardous =>
        appLocalizations.predictionTypeHazardousWasteNote,
      PredictionType.plastic => appLocalizations.predictionTypePlasticNote,
      PredictionType.paper => appLocalizations.predictionTypePaperNote,
      PredictionType.residual =>
        appLocalizations.predictionTypeResidualWasteNote,
    };

    if (v.isEmpty) return null;
    return v;
  }

  Image image() => Image.asset(
    "assets/images/$name.jpg",
    fit: BoxFit.cover,
    isAntiAlias: true,
    filterQuality: FilterQuality.medium,
  );
}
