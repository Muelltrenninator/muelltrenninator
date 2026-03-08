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
  /// **'# “No camera available on this device” Troubleshoot\n\nDatly right now is unable to access your camera. This can have a variety of causes. The most commons are listed below.\n\n- Another application is using the camera\n\n  - Please close all other applications that might be using the camera and try again.\n\n  - Sometimes other browser tabs can also block the camera, so please also try closing other tabs that might be using the camera.\n\n- Hardware issue or temporary glitch\n\n  - Please check your camera settings to ensure it is properly configured and recognized by your device.\n  - Try restarting your device, as this can often resolve temporary hardware glitches.\n  - If the problem persists, please consult your device documentation or support for further troubleshooting steps.'**
  String get cameraErrorUnavailableDescription;

  /// Button text to open the troubleshooting information for camera errors.
  ///
  /// In en, this message translates to:
  /// **'Troubleshoot'**
  String get cameraErrorTroubleshoot;

  /// Title for the camera selection dialog.
  ///
  /// In en, this message translates to:
  /// **'Select camera'**
  String get selectCamera;

  /// The word 'Back' used to describe a camera facing away from the user. This string is formatted in MLA title case.
  ///
  /// In en, this message translates to:
  /// **'Back Camera'**
  String get selectCameraDescriptionBack;

  /// The word 'Front' used to describe a camera facing towards the user. This string is formatted in MLA title case.
  ///
  /// In en, this message translates to:
  /// **'Front Camera'**
  String get selectCameraDescriptionFront;

  /// The word 'External' used to describe an external camera. This string is formatted in MLA title case.
  ///
  /// In en, this message translates to:
  /// **'External Camera'**
  String get selectCameraDescriptionExternal;

  /// Title for the image analysis result screen.
  ///
  /// In en, this message translates to:
  /// **'Image Analysis'**
  String get resultTitle;

  /// Accessibility label for the account overview section.
  ///
  /// In en, this message translates to:
  /// **'Account overview'**
  String get accountOverview;

  /// Accessibility label for the account overview section including the username. This must match the `accountOverview` string.
  ///
  /// In en, this message translates to:
  /// **'for {username}'**
  String accountOverviewFor(String username);

  /// Label for a button that leads to more information about the app.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get aboutAppLearnMore;

  /// Label for a button that logs the user out of the app.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get aboutAppLogout;

  /// A thank you note in the about section of the app.
  ///
  /// In en, this message translates to:
  /// **'Many thanks to Kitan for helping design the app icon!'**
  String get aboutThankYou;

  /// Title for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Organic'**
  String get predictionTypeOrganicTitle;

  /// Description for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Biodegradable waste that comes from plants or animals.'**
  String get predictionTypeOrganicDescription;

  /// Examples for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'vegetable scraps, garden waste, coffee grounds'**
  String get predictionTypeOrganicExamples;

  /// Negative examples for the organic prediction type.
  ///
  /// In en, this message translates to:
  /// **'other food, plastic wrapped items, metals'**
  String get predictionTypeOrganicNegativeExamples;

  /// Title for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Hazardous Waste'**
  String get predictionTypeHazardousWasteTitle;

  /// Description for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Waste that contains hazardous materials that require special handling and disposal.'**
  String get predictionTypeHazardousWasteDescription;

  /// Examples for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'used batteries, paint cans, fluorescent tubes'**
  String get predictionTypeHazardousWasteExamples;

  /// Negative examples for the hazardous waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'food scraps, paper products, plastic containers'**
  String get predictionTypeHazardousWasteNegativeExamples;

  /// Title for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Plastic'**
  String get predictionTypePlasticTitle;

  /// Description for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'Packaging materials made from plastic polymers.'**
  String get predictionTypePlasticDescription;

  /// Examples for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'plastic bottles, wrappers, containers'**
  String get predictionTypePlasticExamples;

  /// Negative examples for the plastic prediction type.
  ///
  /// In en, this message translates to:
  /// **'glass items, metal cans, paper products'**
  String get predictionTypePlasticNegativeExamples;

  /// Title for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get predictionTypePaperTitle;

  /// Description for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'Materials made from wood pulp, such as newspapers and cardboard.'**
  String get predictionTypePaperDescription;

  /// Examples for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'newspapers, cardboard boxes, magazines'**
  String get predictionTypePaperExamples;

  /// Negative examples for the paper prediction type.
  ///
  /// In en, this message translates to:
  /// **'plastic-coated items, contaminated paper, tissues'**
  String get predictionTypePaperNegativeExamples;

  /// Title for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Residual Waste'**
  String get predictionTypeResidualWasteTitle;

  /// Description for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'Non-recyclable waste that cannot be composted or recycled.'**
  String get predictionTypeResidualWasteDescription;

  /// Examples for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'contaminated packaging, ceramics, diapers'**
  String get predictionTypeResidualWasteExamples;

  /// Negative examples for the residual waste prediction type.
  ///
  /// In en, this message translates to:
  /// **'recyclable materials, organic waste, hazardous waste'**
  String get predictionTypeResidualWasteNegativeExamples;

  /// Suffix appended to example search queries to find recycling information.
  ///
  /// In en, this message translates to:
  /// **'correct disposal'**
  String get predictionExampleSearchSuffix;
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
