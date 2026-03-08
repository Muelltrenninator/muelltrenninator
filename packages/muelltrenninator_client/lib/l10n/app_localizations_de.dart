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
  String get failedToLoadDocument => 'Fehler beim Laden des Dokuments.';

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
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get imprint => 'Impressum';

  @override
  String get cameraNotFound => 'Keine Kamera gefunden';

  @override
  String get cameraErrorPermission =>
      'Der Zugriff auf die Kamera wurde verweigert.';

  @override
  String get cameraErrorUnavailable =>
      'Keine Kamera auf diesem Gerät verfügbar.';

  @override
  String get cameraErrorUnavailableDescription =>
      '# „Keine Kamera auf diesem Gerät verfügbar“ Fehlerbehebung\n\nDatly kann derzeit nicht auf deine Kamera zugreifen. Dies kann verschiedene Ursachen haben. Die häufigsten sind unten aufgeführt.\n\n- Eine andere Anwendung verwendet die Kamera\n\n  - Bitte schließe alle anderen Anwendungen, die die Kamera verwenden könnten, und versuche es erneut.\n\n  - Manchmal können auch andere Browser-Tabs die Kamera blockieren, also versuche bitte auch, andere Tabs zu schließen, die die Kamera verwenden könnten.\n\n- Hardwareproblem oder vorübergehender Fehler\n\n  - Bitte überprüfe deine Kameraeinstellungen, um sicherzustellen, dass sie ordnungsgemäß konfiguriert und von deinem Gerät erkannt wird.\n  - Versuche, dein Gerät neu zu starten, da dies oft vorübergehende Hardwarefehler beheben kann.\n  - Wenn das Problem weiterhin besteht, konsultiere bitte die Dokumentation deines Geräts oder den Support für weitere Schritte zur Fehlerbehebung.';

  @override
  String get cameraErrorTroubleshoot => 'Fehlerbehebung';

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
      'Biologisch abbaubarer Abfall, der von Pflanzen oder Tieren stammt.';

  @override
  String get predictionTypeOrganicExamples =>
      'Gemüsereste, Gartenabfälle, Kaffeesatz';

  @override
  String get predictionTypeOrganicNegativeExamples =>
      'andere Lebensmittel, in Plastik verpackte Gegenstände, Metalle';

  @override
  String get predictionTypeHazardousWasteTitle => 'Sondermüll';

  @override
  String get predictionTypeHazardousWasteDescription =>
      'Abfall, der gefährliche Materialien enthält, die eine spezielle Handhabung und Entsorgung erfordern.';

  @override
  String get predictionTypeHazardousWasteExamples =>
      'gebrauchte Batterien, Farbdosen, Leuchtstoffröhren';

  @override
  String get predictionTypeHazardousWasteNegativeExamples =>
      'Lebensmittelreste, Papierprodukte, Plastikbehälter';

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
