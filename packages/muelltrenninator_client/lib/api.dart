import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'l10n/app_localizations.dart';
import 'main.dart';

class ApiManager {
  ApiManager._();
  static final ApiManager _instance = ApiManager._();
  static ApiManager get instance => _instance;

  static Uri get baseUri =>
      kDebugMode ? Uri.parse("http://localhost:33553/api") : Uri.parse("/api");
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
  electronicWaste,
  plastic,
  paper,
  residualWaste;

  String title(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicTitle;
      case PredictionType.electronicWaste:
        return appLocalizations.predictionTypeElectronicWasteTitle;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticTitle;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperTitle;
      case PredictionType.residualWaste:
        return appLocalizations.predictionTypeResidualWasteTitle;
    }
  }

  String description(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicDescription;
      case PredictionType.electronicWaste:
        return appLocalizations.predictionTypeElectronicWasteDescription;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticDescription;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperDescription;
      case PredictionType.residualWaste:
        return appLocalizations.predictionTypeResidualWasteDescription;
    }
  }

  String examples(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicExamples;
      case PredictionType.electronicWaste:
        return appLocalizations.predictionTypeElectronicWasteExamples;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticExamples;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperExamples;
      case PredictionType.residualWaste:
        return appLocalizations.predictionTypeResidualWasteExamples;
    }
  }

  String negativeExamples(AppLocalizations appLocalizations) {
    switch (this) {
      case PredictionType.organic:
        return appLocalizations.predictionTypeOrganicNegativeExamples;
      case PredictionType.electronicWaste:
        return appLocalizations.predictionTypeElectronicWasteNegativeExamples;
      case PredictionType.plastic:
        return appLocalizations.predictionTypePlasticNegativeExamples;
      case PredictionType.paper:
        return appLocalizations.predictionTypePaperNegativeExamples;
      case PredictionType.residualWaste:
        return appLocalizations.predictionTypeResidualWasteNegativeExamples;
    }
  }

  String get apiString {
    switch (this) {
      case PredictionType.organic:
        return "bio";
      case PredictionType.electronicWaste:
        return "elektroschrott";
      case PredictionType.plastic:
        return "gelber_sack";
      case PredictionType.paper:
        return "papier";
      case PredictionType.residualWaste:
        return "restmuell";
    }
  }
}
