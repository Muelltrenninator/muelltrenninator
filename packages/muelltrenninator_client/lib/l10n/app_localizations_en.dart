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
  String get failedToLoadDocument => 'Failed to load document.';

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
  String get cameraErrorUnavailableDescription =>
      '# Camera Troubleshoot\n\nDatly is currently unable to access your camera. This can have a variety of causes. The most commons are listed below.\n\n- Another application is using the camera\n\n  - Please close all other applications that might be using the camera and try again.\n\n  - Sometimes other browser tabs can also block the camera, so please also try closing other tabs that might be using the camera.\n\n- Hardware issue or temporary glitch\n\n  - Please check your camera settings to ensure it is properly configured and recognized by your device.\n  - Try restarting your device, as this can often resolve temporary hardware glitches.\n  - If the problem persists, please consult your device documentation or support for further troubleshooting steps.';

  @override
  String get cameraErrorTroubleshoot => 'Troubleshoot';

  @override
  String get aboutAppLearnMore => 'Learn more';

  @override
  String get aboutThankYou =>
      'Many thanks to Kitan for helping design the app icon!';

  @override
  String get predictionTitle => 'Sorting Result';

  @override
  String get predictionCategoryPrefix => 'I think this is';

  @override
  String get predictionUnknownPrefix => 'I’m afraid I’m';

  @override
  String get predictionUnknownSuffix => 'Not sure';

  @override
  String get predictionOthersPrefix => 'Other categories that might fit';

  @override
  String get predictionOthersNoTopPrefix => 'Categories that might fit';

  @override
  String get predictionNoTopReasonSpread =>
      'The scores are spread too evenly across categories to pick a clear winner.';

  @override
  String get predictionNoTopReasonTied =>
      'A few results are too close to call.';

  @override
  String get predictionNoTopReasonBoth =>
      'The scores are too spread out, and a few results are nearly tied.';

  @override
  String get predictionNoTopTryAgainHint =>
      'Try taking another photo for a better result.';

  @override
  String get predictionLoadingHint1 => 'Hmm, let me take a good look at that…';

  @override
  String get predictionLoadingHint2 => 'Cross-referencing all the bins…';

  @override
  String get predictionLoadingHint3 => 'Taking this one very seriously…';

  @override
  String get predictionLoadingHint4 => 'Weighing up the options…';

  @override
  String get predictionLoadingHint5 => 'Almost there, just double-checking…';

  @override
  String get predictionLoadingHint6 => 'This might be a tricky one…';

  @override
  String get predictionLoadingHint7 => 'Ooh, interesting one…';

  @override
  String get predictionLoadingHint8 => 'Checking the fine print…';

  @override
  String get predictionLoadingHint9 => 'Putting on my sorting hat…';

  @override
  String get predictionLoadingHint10 => 'Getting a second opinion…';

  @override
  String get predictionLoadingHint11 => 'Squinting just to make sure…';

  @override
  String get predictionLoadingHint12 => 'Hmm, which bin though…';

  @override
  String get predictionLoadingHint13 => 'Let me ask the recycling committee…';

  @override
  String get predictionLoadingHint14 => 'Thinking out loud…';

  @override
  String get predictionLoadingHint15 => 'Giving this my full attention…';

  @override
  String get predictionLoadingHint16 => 'Algorithm is deep in thought…';

  @override
  String get predictionLoadingHint17 => 'Running the numbers…';

  @override
  String get predictionLoadingHint18 => 'Almost convinced, just one more look…';

  @override
  String get predictionLoadingHint19 => 'The bins are counting on me…';

  @override
  String get predictionLoadingHint20 => 'Finding its forever home…';

  @override
  String get predictionLoadingHint21 => 'Making the planet proud…';

  @override
  String get predictionTypeOrganicTitle => 'Organic Waste';

  @override
  String get predictionTypeOrganicDescription =>
      'Biodegradable kitchen and garden waste collected separately for composting or biogas production.';

  @override
  String get predictionTypeOrganicShortDescription =>
      'Food and garden waste that decomposes naturally.';

  @override
  String get predictionTypeOrganicPositiveExamples =>
      'fruit and vegetable peels, coffee grounds, tea leaves, eggshells, wilted flowers, grass clippings';

  @override
  String get predictionTypeOrganicNegativeExamples =>
      'packaging, plastic bags, liquids, diapers, cat litter, glass';

  @override
  String get predictionTypeOrganicNote =>
      'Rules for cooked food, meat, bones, and compostable bags vary locally.';

  @override
  String get predictionTypeHazardousWasteTitle => 'Special Waste';

  @override
  String get predictionTypeHazardousWasteDescription =>
      'Items that don’t fit standard household bins and require separate drop-off or special handling.';

  @override
  String get predictionTypeHazardousWasteShortDescription =>
      'Harmful items needing special disposal or drop-off.';

  @override
  String get predictionTypeHazardousWastePositiveExamples =>
      'batteries, re­charge­able batteries, leftover paint, solvents, pes­ti­cides, flu­o­res­cent tubes';

  @override
  String get predictionTypeHazardousWasteNegativeExamples =>
      'plastic toys, tooth­brush­es, buckets, banana peels, news­pa­pers, yogurt cups';

  @override
  String get predictionTypeHazardousWasteNote => '';

  @override
  String get predictionTypePlasticTitle => 'Yellow Bin Packaging';

  @override
  String get predictionTypePlasticDescription =>
      'Everyday sales packaging made of plastic, metal, or composite materials, sorted through Germany’s yellow bin system.';

  @override
  String get predictionTypePlasticShortDescription =>
      'Packaging made of plastic, metal, or composites.';

  @override
  String get predictionTypePlasticPositiveExamples =>
      'yogurt cups, plastic tubs, drink cartons, aluminum lids, tin cans, plastic wrappers';

  @override
  String get predictionTypePlasticNegativeExamples =>
      'plastic toys, tooth­brush­es, elec­tron­ic devices, paper, glass bottles, bulky plastic items';

  @override
  String get predictionTypePlasticNote =>
      'Only packaging belongs here; it should be emptied, not washed spotless.';

  @override
  String get predictionTypePaperTitle => 'Paper & Cardboard';

  @override
  String get predictionTypePaperDescription =>
      'Clean, dry paper and cardboard that can be recycled into new paper products.';

  @override
  String get predictionTypePaperShortDescription =>
      'Clean, dry paper and cardboard for recycling.';

  @override
  String get predictionTypePaperPositiveExamples =>
      'news­pa­pers, flyers, shipping boxes, paper bags, notebooks, egg cartons';

  @override
  String get predictionTypePaperNegativeExamples =>
      'tissues, greasy pizza boxes, coated paper cups, drink cartons, wallpaper, receipts';

  @override
  String get predictionTypePaperNote =>
      'Wet or greasy paper goes to residual waste.';

  @override
  String get predictionTypeResidualWasteTitle => 'Residual Waste';

  @override
  String get predictionTypeResidualWasteDescription =>
      'Mixed household waste that cannot be recycled or composted, including everyday non-packaging plastic items.';

  @override
  String get predictionTypeResidualWasteShortDescription =>
      'Mixed waste that doesn’t fit any other bin.';

  @override
  String get predictionTypeResidualWastePositiveExamples =>
      'diapers, cat litter, sanitary products, broken ceramics, plastic toys, tooth­brush­es';

  @override
  String get predictionTypeResidualWasteNegativeExamples =>
      'batteries, elec­tron­ic devices, glass bottles, paper, packaging, food scraps';

  @override
  String get predictionTypeResidualWasteNote => '';
}
