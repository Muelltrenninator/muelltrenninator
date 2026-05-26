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
      '# Kamera Fehlerbehebung\n\nDatly kann derzeit nicht auf deine Kamera zugreifen. Dies kann verschiedene Ursachen haben. Die häufigsten sind unten aufgeführt.\n\n- Eine andere Anwendung verwendet die Kamera\n\n  - Bitte schließe alle anderen Anwendungen, die die Kamera verwenden könnten, und versuche es erneut.\n\n  - Manchmal können auch andere Browser-Tabs die Kamera blockieren, also versuche bitte auch, andere Tabs zu schließen, die die Kamera verwenden könnten.\n\n- Hardwareproblem oder vorübergehender Fehler\n\n  - Bitte überprüfe deine Kameraeinstellungen, um sicherzustellen, dass sie ordnungsgemäß konfiguriert und von deinem Gerät erkannt wird.\n  - Versuche, dein Gerät neu zu starten, da dies oft vorübergehende Hardwarefehler beheben kann.\n  - Wenn das Problem weiterhin besteht, konsultiere bitte die Dokumentation deines Geräts oder den Support für weitere Schritte zur Fehlerbehebung.';

  @override
  String get cameraErrorTroubleshoot => 'Fehlerbehebung';

  @override
  String get aboutAppLearnMore => 'Mehr erfahren';

  @override
  String get aboutThankYou =>
      'Vielen Dank an Kitan für die Hilfe bei der Gestaltung des App-Icons!';

  @override
  String get predictionTitle => 'Sortierergebnis';

  @override
  String get predictionCategoryPrefix => 'Ich denke, das ist';

  @override
  String get predictionUnknownPrefix => 'Ich fürchte, ich bin mir';

  @override
  String get predictionUnknownSuffix => 'Unsicher';

  @override
  String get predictionOthersPrefix => 'Weitere mögliche Kategorien';

  @override
  String get predictionOthersNoTopPrefix => 'Mögliche Kategorien';

  @override
  String get predictionNoTopReasonSpread =>
      'Die Werte sind zu gleichmäßig verteilt, um eine eindeutige Kategorie zu bestimmen.';

  @override
  String get predictionNoTopReasonTied =>
      'Einige Ergebnisse liegen zu nah beieinander.';

  @override
  String get predictionNoTopReasonBoth =>
      'Die Werte sind zu gleichmäßig verteilt und einige Ergebnisse liegen zu nah beieinander.';

  @override
  String get predictionNoTopTryAgainHint =>
      'Mach ein neues Foto für ein besseres Ergebnis.';

  @override
  String get predictionLoadingHint1 => 'Lass mal sehen, was wir hier haben…';

  @override
  String get predictionLoadingHint2 => 'Die Tonnen werden abgeglichen…';

  @override
  String get predictionLoadingHint3 => 'Das nehme ich sehr ernst…';

  @override
  String get predictionLoadingHint4 => 'Mal alle Optionen abwägen…';

  @override
  String get predictionLoadingHint5 =>
      'Fast fertig, kurz nochmal drüberschauen…';

  @override
  String get predictionLoadingHint6 => 'Das könnte knifflig werden…';

  @override
  String get predictionLoadingHint7 => 'Ooh, sehr spannend…';

  @override
  String get predictionLoadingHint8 => 'Das Kleingedruckte lesen…';

  @override
  String get predictionLoadingHint9 => 'Den Sortierhut aufsetzen…';

  @override
  String get predictionLoadingHint10 => 'Da hol ich mal eine Zweitmeinung ein…';

  @override
  String get predictionLoadingHint11 => 'Nochmal genau hingeschaut…';

  @override
  String get predictionLoadingHint12 => 'Hmm, welche Tonne bloß…';

  @override
  String get predictionLoadingHint13 => 'Das Recycling-Komitee wird befragt…';

  @override
  String get predictionLoadingHint14 => 'Laut nachdenken…';

  @override
  String get predictionLoadingHint15 => 'Volle Konzentration jetzt…';

  @override
  String get predictionLoadingHint16 =>
      'Algorithmus denkt gerade intensiv nach…';

  @override
  String get predictionLoadingHint17 => 'Mit Zahlen jonglieren…';

  @override
  String get predictionLoadingHint18 =>
      'Fast überzeugt, noch ein letzter Blick…';

  @override
  String get predictionLoadingHint19 => 'Die Tonnen verlassen sich auf mich…';

  @override
  String get predictionLoadingHint20 => 'Das findet seinen Platz…';

  @override
  String get predictionLoadingHint21 => 'Den Planeten stolz machen…';

  @override
  String get predictionTypeOrganicTitle => 'Bioabfall';

  @override
  String get predictionTypeOrganicDescription =>
      'Biologisch abbaubare Küchen- und Gartenabfälle, die getrennt zu Kompost oder Biogas verarbeitet werden.';

  @override
  String get predictionTypeOrganicShortDescription =>
      'Küchen- und Gartenabfälle, die biologisch abbaubar sind.';

  @override
  String get predictionTypeOrganicPositiveExamples =>
      'Obst- und Ge­mü­se­scha­len, Kaf­fee­satz, Tee­blät­ter, Eier­scha­len, verwelkte Blumen, Ra­sen­schnitt';

  @override
  String get predictionTypeOrganicNegativeExamples =>
      'Ver­pa­ckun­gen, Plas­tik­beu­tel, Flüss­ig­kei­ten, Windeln, Kat­zen­streu, Glas';

  @override
  String get predictionTypeOrganicNote =>
      'Für gekochte Speisereste, Fleisch, Knochen und kompostierbare Beutel gelten örtlich unterschiedliche Regeln.';

  @override
  String get predictionTypeHazardousWasteTitle => 'Sondermüll';

  @override
  String get predictionTypeHazardousWasteDescription =>
      'Gegenstände, die nicht in normale Haushaltstonnen gehören und separat abgegeben oder gesondert entsorgt werden müssen.';

  @override
  String get predictionTypeHazardousWasteShortDescription =>
      'Schadstoffe und Problemabfälle mit gesonderter Entsorgungspflicht.';

  @override
  String get predictionTypeHazardousWastePositiveExamples =>
      'Batterien, Akkus, Lackreste, Lö­sungs­mit­tel, Pflan­zen­schutz­mit­tel, Ener­gie­spar­lam­pen';

  @override
  String get predictionTypeHazardousWasteNegativeExamples =>
      'Plas­tik­spiel­zeug, Zahn­bürs­ten, Eimer, Ba­na­nen­scha­len, Zeitungen, Jog­hurt­be­cher';

  @override
  String get predictionTypeHazardousWasteNote => '';

  @override
  String get predictionTypePlasticTitle => 'Gelbe Tonne';

  @override
  String get predictionTypePlasticDescription =>
      'Verpackungen aus Kunststoff, Metall oder Verbundmaterial, die über die Gelbe Tonne getrennt erfasst werden.';

  @override
  String get predictionTypePlasticShortDescription =>
      'Verpackungen aus Kunststoff, Metall oder Verbundmaterial.';

  @override
  String get predictionTypePlasticPositiveExamples =>
      'Jog­hurt­be­cher, Kunst­stoff­scha­len, Ge­trän­ke­kar­tons, Aludeckel, Kon­ser­ven­do­sen, Fo­li­en­ver­pa­ckun­gen';

  @override
  String get predictionTypePlasticNegativeExamples =>
      'Plas­tik­spiel­zeug, Zahn­bürs­ten, Elek­tro­ge­rä­te, Papier, Glas­fla­schen, sperrige Kunst­stoff­tei­le';

  @override
  String get predictionTypePlasticNote =>
      'Hier gehören nur Verpackungen hinein; sie sollten restentleert sein, müssen aber nicht blitzsauber gespült werden.';

  @override
  String get predictionTypePaperTitle => 'Papier & Pappe';

  @override
  String get predictionTypePaperDescription =>
      'Sauberes, trockenes Papier und Pappe, die zu neuen Papierprodukten recycelt werden können.';

  @override
  String get predictionTypePaperShortDescription =>
      'Sauberes, trockenes Papier und Pappe zum Recyceln.';

  @override
  String get predictionTypePaperPositiveExamples =>
      'Zeitungen, Prospekte, Ver­sand­kar­tons, Pa­pier­tü­ten, Hefte, Eier­kar­tons';

  @override
  String get predictionTypePaperNegativeExamples =>
      'Ta­schen­tü­cher, fettige Piz­za­kar­tons, be­schich­te­te Papp­be­cher, Ge­trän­ke­kar­tons, Tapeten, Kas­sen­bons';

  @override
  String get predictionTypePaperNote =>
      'Nasses oder fettiges Papier gehört in den Restmüll.';

  @override
  String get predictionTypeResidualWasteTitle => 'Restmüll';

  @override
  String get predictionTypeResidualWasteDescription =>
      'Gemischte Haushaltsabfälle, die sich nicht recyceln oder kompostieren lassen, darunter auch Kunststoffgegenstände, die keine Verpackungen sind.';

  @override
  String get predictionTypeResidualWasteShortDescription =>
      'Gemischter Abfall ohne passende Recyclingkategorie.';

  @override
  String get predictionTypeResidualWastePositiveExamples =>
      'Windeln, Kat­zen­streu, Hy­gie­ne­ar­ti­kel, zer­bro­che­ne Keramik, Plas­tik­spiel­zeug, Zahn­bürs­ten';

  @override
  String get predictionTypeResidualWasteNegativeExamples =>
      'Batterien, Elek­tro­ge­rä­te, Glas­fla­schen, Papier, Ver­pa­ckun­gen, Bio­ab­fäl­le';

  @override
  String get predictionTypeResidualWasteNote => '';
}
