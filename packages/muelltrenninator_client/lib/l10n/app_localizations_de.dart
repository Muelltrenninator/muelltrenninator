// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String quote(String content) {
    return '„$content“';
  }

  @override
  String get retry => 'Erneut Versuchen';

  @override
  String get loginError =>
      'Server nicht erreichbar. Bitte überprüfe deine Internetverbindung.';

  @override
  String get loginUnknown => 'Unbekannter Logincode.';

  @override
  String get loginCodeLabel => 'Logincode';

  @override
  String get loginNewHere => 'Neu hier?';

  @override
  String get loginNewHereRequest => 'Einen Code anfordern.';

  @override
  String get loginPrivacyPolicy => 'Datenschutzerklärung';

  @override
  String get loginTermsOfService => 'Nutzungsbedingungen';

  @override
  String get cameraNotFound => 'Keine Kamera gefunden';

  @override
  String get cameraErrorPermission =>
      'Der Zugriff auf die Kamera wurde verweigert.';

  @override
  String get cameraErrorUnavailable =>
      'Keine Kamera auf diesem Gerät verfügbar.';

  @override
  String get selectCamera => 'Kamera auswählen';

  @override
  String get selectCameraDescriptionBack => 'Rückkamera';

  @override
  String get selectCameraDescriptionFront => 'Frontkamera';

  @override
  String get selectCameraDescriptionExternal => 'Externe Kamera';

  @override
  String get resultTitle => 'Bildanalyse';

  @override
  String get accountOverview => 'Account-Übersicht';

  @override
  String accountOverviewFor(String username) {
    return 'für $username';
  }

  @override
  String get aboutAppLearnMore => 'Mehr erfahren';

  @override
  String get aboutAppLogout => 'Abmelden';

  @override
  String get aboutThankYou =>
      'Vielen Dank an Kitan für die Hilfe bei der Gestaltung des App-Icons!';

  @override
  String get predictionTypeOrganicTitle => 'Biomüll';

  @override
  String get predictionTypeOrganicDescription =>
      'Abfall, der biologisch abbaubar ist und von Pflanzen oder Tieren stammt.';

  @override
  String get predictionTypeOrganicExamples =>
      'Gemüsereste, Gartenabfälle, Kaffeesatz';

  @override
  String get predictionTypeOrganicNegativeExamples =>
      'andere Lebensmittel, in Plastik verpackte Gegenstände, Metalle';

  @override
  String get predictionTypeElectronicWasteTitle => 'Elektroschrott';

  @override
  String get predictionTypeElectronicWasteDescription =>
      'Ausrangierte elektronische Geräte oder Komponenten.';

  @override
  String get predictionTypeElectronicWasteExamples =>
      'alte Telefone, kaputte Geräte, Toaster';

  @override
  String get predictionTypeElectronicWasteNegativeExamples =>
      'Batterien, Kabel, LED-Glühbirnen';

  @override
  String get predictionTypePlasticTitle => 'Gelber Sack';

  @override
  String get predictionTypePlasticDescription =>
      'Verpackungsmaterialien aus Plastik.';

  @override
  String get predictionTypePlasticExamples =>
      'Plastikflaschen, Verpackungen, Behälter';

  @override
  String get predictionTypePlasticNegativeExamples =>
      'Glasgegenstände, Metalldosen, Papierprodukte';

  @override
  String get predictionTypePaperTitle => 'Papier';

  @override
  String get predictionTypePaperDescription =>
      'Materialien aus Zellstoff, wie Zeitungen und Pappe.';

  @override
  String get predictionTypePaperExamples =>
      'Zeitungen, Pappkartons, Zeitschriften';

  @override
  String get predictionTypePaperNegativeExamples =>
      'kunststoffbeschichtete Gegenstände, verunreinigtes Papier, Taschentücher';

  @override
  String get predictionTypeResidualWasteTitle => 'Restmüll';

  @override
  String get predictionTypeResidualWasteDescription =>
      'Nicht recycelbarer Abfall, der nicht kompostiert oder wiederverwertet werden kann.';

  @override
  String get predictionTypeResidualWasteExamples =>
      'verunreinigte Verpackungen, Keramik, Windeln';

  @override
  String get predictionTypeResidualWasteNegativeExamples =>
      'recycelbare Materialien, Bioabfall, Sondermüll';

  @override
  String get predictionExampleSearchSuffix => 'korrekte Entsorgung';
}
