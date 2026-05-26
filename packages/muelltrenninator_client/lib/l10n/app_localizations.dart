import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
  ];

  /// A quotation format that wraps the content in quotation marks.
  ///
  /// In en, this message translates to:
  /// **'“{content}”'**
  String quote(String content);

  /// Button text to retry accessing the camera.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Error message shown when a legal document fails to load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load document.'**
  String get failedToLoadDocument;

  /// Error message shown when the server cannot be reached during login.
  ///
  /// In en, this message translates to:
  /// **'Server unreachable. Please check your internet connection.'**
  String get loginError;

  /// Error message shown when the provided login code is not recognized.
  ///
  /// In en, this message translates to:
  /// **'Unknown login code.'**
  String get loginUnknown;

  /// Label for the login code input field.
  ///
  /// In en, this message translates to:
  /// **'Login code'**
  String get loginCodeLabel;

  /// Text prompting new users to request a login code.
  ///
  /// In en, this message translates to:
  /// **'New here?'**
  String get loginNewHere;

  /// Link text for new users to request a login code.
  ///
  /// In en, this message translates to:
  /// **'Request a code.'**
  String get loginNewHereRequest;

  /// Link text for the app's terms of service. This string is formatted in MLA title case.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Link text for the app's privacy policy. This string is formatted in MLA title case.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Link text for the app's imprint. This string is formatted in MLA title case.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get imprint;

  /// Shown when no camera device is found on the system or the permission is denied.
  ///
  /// In en, this message translates to:
  /// **'No camera found'**
  String get cameraNotFound;

  /// Explains that access to the camera was denied by the user.
  ///
  /// In en, this message translates to:
  /// **'Access to the camera was denied.'**
  String get cameraErrorPermission;

  /// Shown when the camera is unavailable on the device, for example because it is being used by another application or there is a hardware issue.
  ///
  /// In en, this message translates to:
  /// **'No camera available on this device.'**
  String get cameraErrorUnavailable;

  /// Additional explanation for the camera unavailable error, providing possible causes and troubleshooting steps.
  ///
  /// In en, this message translates to:
  /// **'# Camera Troubleshoot\n\nDatly is currently unable to access your camera. This can have a variety of causes. The most commons are listed below.\n\n- Another application is using the camera\n\n  - Please close all other applications that might be using the camera and try again.\n\n  - Sometimes other browser tabs can also block the camera, so please also try closing other tabs that might be using the camera.\n\n- Hardware issue or temporary glitch\n\n  - Please check your camera settings to ensure it is properly configured and recognized by your device.\n  - Try restarting your device, as this can often resolve temporary hardware glitches.\n  - If the problem persists, please consult your device documentation or support for further troubleshooting steps.'**
  String get cameraErrorUnavailableDescription;

  /// Button text to open the troubleshooting information for camera errors.
  ///
  /// In en, this message translates to:
  /// **'Troubleshoot'**
  String get cameraErrorTroubleshoot;

  /// Label for a button that leads to more information about the app.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get aboutAppLearnMore;

  /// A thank you note in the about section of the app.
  ///
  /// In en, this message translates to:
  /// **'Many thanks to Kitan for helping design the app icon!'**
  String get aboutThankYou;

  /// Title for the waste category prediction result screen.
  ///
  /// In en, this message translates to:
  /// **'Sorting Result'**
  String get predictionTitle;

  /// Prefix for the predicted waste category.
  ///
  /// In en, this message translates to:
  /// **'I think this is'**
  String get predictionCategoryPrefix;

  /// Prefix shown when the prediction result is unknown.
  ///
  /// In en, this message translates to:
  /// **'I’m afraid I’m'**
  String get predictionUnknownPrefix;

  /// Suffix shown when the prediction result is unknown.
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get predictionUnknownSuffix;

  /// Prefix for the list of other possible waste categories that are not the top prediction.
  ///
  /// In en, this message translates to:
  /// **'Other categories that might fit'**
  String get predictionOthersPrefix;

  /// Prefix for the list of possible waste categories when no top prediction was found.
  ///
  /// In en, this message translates to:
  /// **'Categories that might fit'**
  String get predictionOthersNoTopPrefix;

  /// Explanation shown when no top prediction exists because the probability scores are distributed too evenly (high entropy). Follows the unknown prefix/suffix.
  ///
  /// In en, this message translates to:
  /// **'The scores are spread too evenly across categories to pick a clear winner.'**
  String get predictionNoTopReasonSpread;

  /// Explanation shown when no top prediction exists because the first result is not significantly more confident than the second (confidence ratio below 2×). Follows the unknown prefix/suffix.
  ///
  /// In en, this message translates to:
  /// **'A few results are too close to call.'**
  String get predictionNoTopReasonTied;

  /// Explanation shown when no top prediction exists because both the entropy is too high and the confidence ratio is too low simultaneously. Follows the unknown prefix/suffix.
  ///
  /// In en, this message translates to:
  /// **'The scores are too spread out, and a few results are nearly tied.'**
  String get predictionNoTopReasonBoth;

  /// Hint shown when no top prediction is found, suggesting the user try again with a clearer photo.
  ///
  /// In en, this message translates to:
  /// **'Try taking another photo for a better result.'**
  String get predictionNoTopTryAgainHint;

  /// Cheerful loading hint shown while the AI prediction is being processed (1 of 7).
  ///
  /// In en, this message translates to:
  /// **'Hmm, let me take a good look at that…'**
  String get predictionLoadingHint1;

  /// Cheerful loading hint shown while the AI prediction is being processed (2 of 7).
  ///
  /// In en, this message translates to:
  /// **'Cross-referencing all the bins…'**
  String get predictionLoadingHint2;

  /// Cheerful loading hint shown while the AI prediction is being processed (3 of 7).
  ///
  /// In en, this message translates to:
  /// **'Taking this one very seriously…'**
  String get predictionLoadingHint3;

  /// Cheerful loading hint shown while the AI prediction is being processed (4 of 7).
  ///
  /// In en, this message translates to:
  /// **'Weighing up the options…'**
  String get predictionLoadingHint4;

  /// Cheerful loading hint shown while the AI prediction is being processed (5 of 7).
  ///
  /// In en, this message translates to:
  /// **'Almost there, just double-checking…'**
  String get predictionLoadingHint5;

  /// Cheerful loading hint shown while the AI prediction is being processed (6 of 7).
  ///
  /// In en, this message translates to:
  /// **'This might be a tricky one…'**
  String get predictionLoadingHint6;

  /// Cheerful loading hint shown while the AI prediction is being processed (7 of 21).
  ///
  /// In en, this message translates to:
  /// **'Ooh, interesting one…'**
  String get predictionLoadingHint7;

  /// Cheerful loading hint shown while the AI prediction is being processed (8 of 21).
  ///
  /// In en, this message translates to:
  /// **'Checking the fine print…'**
  String get predictionLoadingHint8;

  /// Cheerful loading hint shown while the AI prediction is being processed (9 of 21).
  ///
  /// In en, this message translates to:
  /// **'Putting on my sorting hat…'**
  String get predictionLoadingHint9;

  /// Cheerful loading hint shown while the AI prediction is being processed (10 of 21).
  ///
  /// In en, this message translates to:
  /// **'Getting a second opinion…'**
  String get predictionLoadingHint10;

  /// Cheerful loading hint shown while the AI prediction is being processed (11 of 21).
  ///
  /// In en, this message translates to:
  /// **'Squinting just to make sure…'**
  String get predictionLoadingHint11;

  /// Cheerful loading hint shown while the AI prediction is being processed (12 of 21).
  ///
  /// In en, this message translates to:
  /// **'Hmm, which bin though…'**
  String get predictionLoadingHint12;

  /// Cheerful loading hint shown while the AI prediction is being processed (13 of 21).
  ///
  /// In en, this message translates to:
  /// **'Let me ask the recycling committee…'**
  String get predictionLoadingHint13;

  /// Cheerful loading hint shown while the AI prediction is being processed (14 of 21).
  ///
  /// In en, this message translates to:
  /// **'Thinking out loud…'**
  String get predictionLoadingHint14;

  /// Cheerful loading hint shown while the AI prediction is being processed (15 of 21).
  ///
  /// In en, this message translates to:
  /// **'Giving this my full attention…'**
  String get predictionLoadingHint15;

  /// Cheerful loading hint shown while the AI prediction is being processed (16 of 21).
  ///
  /// In en, this message translates to:
  /// **'Algorithm is deep in thought…'**
  String get predictionLoadingHint16;

  /// Cheerful loading hint shown while the AI prediction is being processed (17 of 21).
  ///
  /// In en, this message translates to:
  /// **'Running the numbers…'**
  String get predictionLoadingHint17;

  /// Cheerful loading hint shown while the AI prediction is being processed (18 of 21).
  ///
  /// In en, this message translates to:
  /// **'Almost convinced, just one more look…'**
  String get predictionLoadingHint18;

  /// Cheerful loading hint shown while the AI prediction is being processed (19 of 21).
  ///
  /// In en, this message translates to:
  /// **'The bins are counting on me…'**
  String get predictionLoadingHint19;

  /// Cheerful loading hint shown while the AI prediction is being processed (20 of 21).
  ///
  /// In en, this message translates to:
  /// **'Finding its forever home…'**
  String get predictionLoadingHint20;

  /// Cheerful loading hint shown while the AI prediction is being processed (21 of 21).
  ///
  /// In en, this message translates to:
  /// **'Making the planet proud…'**
  String get predictionLoadingHint21;

  /// Title for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Organic Waste'**
  String get predictionTypeOrganicTitle;

  /// Description for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Biodegradable kitchen and garden waste collected separately for composting or biogas production.'**
  String get predictionTypeOrganicDescription;

  /// Short tagline (max 10 words) for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Food and garden waste that decomposes naturally.'**
  String get predictionTypeOrganicShortDescription;

  /// Examples for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'fruit and vegetable peels, coffee grounds, tea leaves, eggshells, wilted flowers, grass clippings'**
  String get predictionTypeOrganicPositiveExamples;

  /// Negative examples for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'packaging, plastic bags, liquids, diapers, cat litter, glass'**
  String get predictionTypeOrganicNegativeExamples;

  /// Important caveats for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Rules for cooked food, meat, bones, and compostable bags vary locally.'**
  String get predictionTypeOrganicNote;

  /// Title for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Special Waste'**
  String get predictionTypeHazardousWasteTitle;

  /// Description for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Items that don’t fit standard household bins and require separate drop-off or special handling.'**
  String get predictionTypeHazardousWasteDescription;

  /// Short tagline (max 10 words) for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Harmful items needing special disposal or drop-off.'**
  String get predictionTypeHazardousWasteShortDescription;

  /// Examples for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'batteries, re­charge­able batteries, leftover paint, solvents, pes­ti­cides, flu­o­res­cent tubes'**
  String get predictionTypeHazardousWastePositiveExamples;

  /// Negative examples for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'plastic toys, tooth­brush­es, buckets, banana peels, news­pa­pers, yogurt cups'**
  String get predictionTypeHazardousWasteNegativeExamples;

  /// Important caveats for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **''**
  String get predictionTypeHazardousWasteNote;

  /// Title for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Yellow Bin Packaging'**
  String get predictionTypePlasticTitle;

  /// Description for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Everyday sales packaging made of plastic, metal, or composite materials, sorted through Germany’s yellow bin system.'**
  String get predictionTypePlasticDescription;

  /// Short tagline (max 10 words) for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Packaging made of plastic, metal, or composites.'**
  String get predictionTypePlasticShortDescription;

  /// Examples for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'yogurt cups, plastic tubs, drink cartons, aluminum lids, tin cans, plastic wrappers'**
  String get predictionTypePlasticPositiveExamples;

  /// Negative examples for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'plastic toys, tooth­brush­es, elec­tron­ic devices, paper, glass bottles, bulky plastic items'**
  String get predictionTypePlasticNegativeExamples;

  /// Important caveats for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Only packaging belongs here; it should be emptied, not washed spotless.'**
  String get predictionTypePlasticNote;

  /// Title for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'Paper & Cardboard'**
  String get predictionTypePaperTitle;

  /// Description for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'Clean, dry paper and cardboard that can be recycled into new paper products.'**
  String get predictionTypePaperDescription;

  /// Short tagline (max 10 words) for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'Clean, dry paper and cardboard for recycling.'**
  String get predictionTypePaperShortDescription;

  /// Examples for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'news­pa­pers, flyers, shipping boxes, paper bags, notebooks, egg cartons'**
  String get predictionTypePaperPositiveExamples;

  /// Negative examples for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'tissues, greasy pizza boxes, coated paper cups, drink cartons, wallpaper, receipts'**
  String get predictionTypePaperNegativeExamples;

  /// Important caveats for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'Wet or greasy paper goes to residual waste.'**
  String get predictionTypePaperNote;

  /// Title for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Residual Waste'**
  String get predictionTypeResidualWasteTitle;

  /// Description for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Mixed household waste that cannot be recycled or composted, including everyday non-packaging plastic items.'**
  String get predictionTypeResidualWasteDescription;

  /// Short tagline (max 10 words) for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Mixed waste that doesn’t fit any other bin.'**
  String get predictionTypeResidualWasteShortDescription;

  /// Examples for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'diapers, cat litter, sanitary products, broken ceramics, plastic toys, tooth­brush­es'**
  String get predictionTypeResidualWastePositiveExamples;

  /// Negative examples for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'batteries, elec­tron­ic devices, glass bottles, paper, packaging, food scraps'**
  String get predictionTypeResidualWasteNegativeExamples;

  /// Important caveats for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **''**
  String get predictionTypeResidualWasteNote;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
