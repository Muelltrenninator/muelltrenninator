// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String quote(String content) {
    return '“$content”';
  }

  @override
  String get retry => 'Retry';

  @override
  String get loginError =>
      'Server unreachable. Please check your internet connection.';

  @override
  String get loginUnknown => 'Unknown login code.';

  @override
  String get loginCodeLabel => 'Login code';

  @override
  String get loginNewHere => 'New here?';

  @override
  String get loginNewHereRequest => 'Request a code.';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get imprint => 'Imprint';

  @override
  String get cameraNotFound => 'No camera found';

  @override
  String get cameraErrorPermission => 'Access to the camera was denied.';

  @override
  String get cameraErrorUnavailable => 'No camera available on this device.';

  @override
  String get selectCamera => 'Select camera';

  @override
  String get selectCameraDescriptionBack => 'Back Camera';

  @override
  String get selectCameraDescriptionFront => 'Front Camera';

  @override
  String get selectCameraDescriptionExternal => 'External Camera';

  @override
  String get resultTitle => 'Image Analysis';

  @override
  String get accountOverview => 'Account overview';

  @override
  String accountOverviewFor(String username) {
    return 'for $username';
  }

  @override
  String get aboutAppLearnMore => 'Learn more';

  @override
  String get aboutAppLogout => 'Logout';

  @override
  String get aboutThankYou =>
      'Many thanks to Kitan for helping design the app icon!';

  @override
  String get predictionTypeOrganicTitle => 'Organic';

  @override
  String get predictionTypeOrganicDescription =>
      'Biodegradable waste that comes from plants or animals.';

  @override
  String get predictionTypeOrganicExamples =>
      'vegetable scraps, garden waste, coffee grounds';

  @override
  String get predictionTypeOrganicNegativeExamples =>
      'other food, plastic wrapped items, metals';

  @override
  String get predictionTypeHazardousWasteTitle => 'Hazardous Waste';

  @override
  String get predictionTypeHazardousWasteDescription =>
      'Waste that contains hazardous materials that require special handling and disposal.';

  @override
  String get predictionTypeHazardousWasteExamples =>
      'used batteries, paint cans, fluorescent tubes';

  @override
  String get predictionTypeHazardousWasteNegativeExamples =>
      'food scraps, paper products, plastic containers';

  @override
  String get predictionTypePlasticTitle => 'Plastic';

  @override
  String get predictionTypePlasticDescription =>
      'Packaging materials made from plastic polymers.';

  @override
  String get predictionTypePlasticExamples =>
      'plastic bottles, wrappers, containers';

  @override
  String get predictionTypePlasticNegativeExamples =>
      'glass items, metal cans, paper products';

  @override
  String get predictionTypePaperTitle => 'Paper';

  @override
  String get predictionTypePaperDescription =>
      'Materials made from wood pulp, such as newspapers and cardboard.';

  @override
  String get predictionTypePaperExamples =>
      'newspapers, cardboard boxes, magazines';

  @override
  String get predictionTypePaperNegativeExamples =>
      'plastic-coated items, contaminated paper, tissues';

  @override
  String get predictionTypeResidualWasteTitle => 'Residual Waste';

  @override
  String get predictionTypeResidualWasteDescription =>
      'Non-recyclable waste that cannot be composted or recycled.';

  @override
  String get predictionTypeResidualWasteExamples =>
      'contaminated packaging, ceramics, diapers';

  @override
  String get predictionTypeResidualWasteNegativeExamples =>
      'recyclable materials, organic waste, hazardous waste';

  @override
  String get predictionExampleSearchSuffix => 'correct disposal';
}
