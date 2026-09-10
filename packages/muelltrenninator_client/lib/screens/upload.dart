import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:web/web.dart' as web;

import '../api.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import 'terms.dart';

@RoutePage()
class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  int cameraIndex = 0;
  CameraController? controller;

  bool flashAvailable = false;
  FlashMode flashMode = FlashMode.off;

  bool error = false;
  bool noCamera = false;

  late final AnimationController flashAnimationController;
  late final AnimationController flashColorAnimationController;
  late final AnimationController flipAnimationController;

  @override
  void initState() {
    super.initState();
    camerasInitialize().then((_) => loadStoredCamera());

    flashAnimationController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
    flashColorAnimationController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
    flipAnimationController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  Future<void> loadStoredCamera() async {
    bool loaded = false;
    if (prefs.containsKey("camera")) {
      cameraIndex = prefs.getInt("camera")!;
      loaded = true;
    }

    final availableCameras = await cameras.future;
    if (availableCameras.isEmpty) {
      error = true;
      noCamera = true;
      if (mounted) setState(() {});
      return;
    }

    if (!loaded && cameraIndex == 0 && availableCameras.length > 1) {
      final backCameraIndex = availableCameras.indexWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
      if (backCameraIndex != -1) cameraIndex = backCameraIndex;
    }

    await _initializeCameraController(availableCameras[cameraIndex]);
  }

  Future<void> _initializeCameraController(
    CameraDescription description,
  ) async {
    controller = CameraController(
      description,
      ResolutionPreset.low,
      enableAudio: false,
    );

    await controller!.initialize().catchError((_, _) {
      error = true;
      if (mounted) setState(() {});
    });

    try {
      await controller!.setFlashMode(flashMode);
      flashAvailable = true;
    } on CameraException catch (_) {
      flashAvailable = false;
    } on Error catch (e) {
      if (kIsWeb) {
        // workaround for unhandled error in `camera_web` package
        flashAvailable = false;
        web.console.error("Flash error: $e (${e.runtimeType})".jsify());
        web.console.error(e.stackTrace.toString().jsify());
      } else {
        rethrow;
      }
    }

    if (!error && mounted) setState(() {});
  }

  void flashCamera() async {
    final oldFlashMode = flashMode;
    final nextFlash = switch (oldFlashMode) {
      FlashMode.off => FlashMode.torch,
      FlashMode.torch => FlashMode.off,
      _ => FlashMode.off,
    };

    try {
      flashMode = nextFlash;
      await controller?.setFlashMode(flashMode);
      flashAvailable = true;
    } on CameraException catch (_) {
      flashMode = oldFlashMode;
      flashAvailable = false;
    } on Error catch (e) {
      if (kIsWeb) {
        // workaround for unhandled error in `camera_web` package
        flashMode = oldFlashMode;
        flashAvailable = false;
        web.console.error("Flash error: $e (${e.runtimeType})".jsify());
        web.console.error(e.stackTrace.toString().jsify());
      } else {
        rethrow;
      }
    }

    flashAnimationController.forward(from: 0);
    nextFlash == FlashMode.torch
        ? flashColorAnimationController.forward(from: 0)
        : flashColorAnimationController.reverse(from: 1);
    if (mounted) setState(() {});
  }

  void flipCamera() async {
    final availableCameras = await cameras.future;
    if (availableCameras.length < 2 ||
        controller?.value.isInitialized == false ||
        !mounted) {
      return;
    }

    cameraIndex = (cameraIndex + 1) % availableCameras.length;
    prefs.setInt("camera", cameraIndex);
    controller = null;
    if (mounted) setState(() {});

    controller?.dispose();
    flipAnimationController.forward(from: 0);
    await _initializeCameraController(availableCameras[cameraIndex]);
  }

  void submit() async {
    final imageRaw = await controller!.takePicture();
    if (mounted) {
      context.pushRoute(PredictionRoute(image: imageRaw.readAsBytes()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomUpload = WindowSizeClass.of(context) < WindowSizeClass.medium;

    Widget errorWidget() => ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.question_mark_rounded, size: 48),
          SizedBox(height: 12),
          Text(
            AppLocalizations.of(context).cameraNotFound,
            style: TextTheme.of(
              context,
            ).titleLarge!.copyWith(height: 1).stylizedInterface,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            camerasPermissionDenied
                ? AppLocalizations.of(context).cameraErrorPermission
                : AppLocalizations.of(context).cameraErrorUnavailable,
            style: DefaultTextStyle.of(context).style.stylizedInterface,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: 16),
          if (!camerasPermissionDenied) ...[
            OutlinedButton.icon(
              onPressed: () => showMarkdownDialog(
                context: context,
                source: MarkdownDialogStringSource(
                  AppLocalizations.of(
                    context,
                  ).cameraErrorUnavailableDescription,
                ),
              ),
              icon: Icon(Icons.troubleshoot_rounded),
              label: Builder(
                builder: (context) => Text(
                  AppLocalizations.of(context).cameraErrorTroubleshoot,
                  style: DefaultTextStyle.of(context).style.stylizedInterface,
                ),
              ),
            ),
            SizedBox(height: 4),
          ],
          (camerasPermissionDenied ? FilledButton.icon : OutlinedButton.icon)
              .call(
                onPressed: () async {
                  controller?.dispose();
                  controller = null;
                  error = false;
                  if (mounted) setState(() {});

                  await camerasInitialize();
                  await loadStoredCamera();
                },
                label: Builder(
                  builder: (context) => Text(
                    AppLocalizations.of(context).retry,
                    style: DefaultTextStyle.of(context).style.stylizedInterface,
                  ),
                ),
                icon: Icon(Icons.refresh_rounded),
              ),
        ],
      ),
    );

    final content = SizedBox.expand(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        child: AnimatedSwitcher(
          duration: Durations.medium1,
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic.flipped,
          child: !error
              ? controller != null && controller!.value.isInitialized
                    ? GestureDetector(
                        onDoubleTap: flipCamera,
                        child: SizedBox.expand(
                          child: CameraPreview(controller!),
                        ),
                      )
                    : ColoredBox(
                        key: ValueKey("loading"),
                        color: colorScheme.surfaceContainer,
                      )
              : noCamera
              ? ColoredBox(
                  key: ValueKey("errorCamera"),
                  color: colorScheme.surfaceContainer,
                  child: Center(child: errorWidget()),
                )
              : ColoredBox(
                  key: ValueKey("errorUnspecified"),
                  color: colorScheme.surfaceContainer,
                  child: Center(
                    child: Icon(Icons.error_outline_rounded, size: 48),
                  ),
                ),
        ),
      ),
    );

    Widget flashButton = RotationTransition(
      turns:
          TweenSequence([
            TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.04), weight: 1),
            TweenSequenceItem(tween: Tween(begin: -0.04, end: 0.04), weight: 2),
            TweenSequenceItem(tween: Tween(begin: 0.04, end: 0.0), weight: 1),
          ]).animate(
            CurvedAnimation(
              parent: flashAnimationController,
              curve: Curves.bounceInOut,
            ),
          ),
      child: AnimatedBuilder(
        animation: flashColorAnimationController,
        builder: (context, _) => FloatingActionButton(
          onPressed: flashAvailable ? flashCamera : null,
          heroTag: null,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          foregroundColor: bottomUpload
              ? ColorTween(
                  begin: colorScheme.onSurface,
                  end: colorScheme.onPrimary,
                ).evaluate(
                  CurvedAnimation(
                    parent: flashColorAnimationController,
                    curve: Interval(
                      0.25,
                      1,
                      curve: Curves.easeInOutCubicEmphasized,
                    ),
                    reverseCurve: Interval(
                      0,
                      0.75,
                      curve: Curves.easeInOutCubicEmphasized.flipped,
                    ),
                  ),
                )
              : null,
          backgroundColor: bottomUpload
              ? ColorTween(
                  begin: colorScheme.surfaceContainer,
                  end: colorScheme.primary,
                ).evaluate(
                  CurvedAnimation(
                    parent: flashColorAnimationController,
                    curve: Interval(
                      0.25,
                      1,
                      curve: Curves.easeInOutCubicEmphasized,
                    ),
                    reverseCurve: Interval(
                      0,
                      0.75,
                      curve: Curves.easeInOutCubicEmphasized.flipped,
                    ),
                  ),
                )
              : null,
          elevation: bottomUpload ? 0 : null,
          hoverElevation: bottomUpload ? 0 : null,
          child: Icon(
            flashAvailable
                ? Icons.flashlight_on_rounded
                : Icons.no_flash_outlined,
          ),
        ),
      ),
    );
    if (!flashAvailable && !kDebugMode) {
      flashButton = IgnorePointer(
        child: Focus(
          descendantsAreFocusable: false,
          canRequestFocus: false,
          child: Visibility.maintain(visible: false, child: flashButton),
        ),
      );
    }

    final flipCameraButton = FloatingActionButton(
      onPressed: flipCamera,
      heroTag: null,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: bottomUpload ? colorScheme.surfaceContainer : null,
      elevation: bottomUpload ? 0 : null,
      hoverElevation: bottomUpload ? 0 : null,
      child: RotationTransition(
        turns: Tween<double>(begin: 0, end: -0.5).animate(
          CurvedAnimation(
            parent: flipAnimationController,
            curve: Curves.easeInOutCubic,
          ),
        ),
        child: Icon(Icons.cached_rounded),
      ),
    );

    final widget = Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          content,
          IgnorePointer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: bottomUpload ? 0 : 72,
                  bottom: 72,
                ),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: SizedBox.expand(
                      child: CustomPaint(
                        painter: _UploadGuideCornersPainter(
                          color: colorScheme.surfaceContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (bottomUpload) ...[
            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0),
                      Colors.black.withValues(alpha: 0.75),
                    ],
                    stops: [0.75, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SizedBox.expand(),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 48, right: 48),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: flashButton),
                    Expanded(
                      child: FloatingActionButton.large(
                        onPressed: submit,
                        heroTag: null,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: colorScheme.surface,
                            width: 8,
                          ),
                        ),
                        elevation: 0,
                        child: Icon(Icons.location_searching_rounded),
                      ),
                    ),
                    Flexible(child: flipCameraButton),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: !bottomUpload
          ? AnimatedSwitcher(
              duration: Durations.medium1,
              switchInCurve: Curves.easeInOutCubicEmphasized,
              switchOutCurve: Curves.easeInOutCubicEmphasized.flipped,
              transitionBuilder: (child, animation) => SlideTransition(
                position: (Tween<Offset>(
                  begin: Offset(0, 1.1),
                  end: Offset(0, 0),
                )).animate(animation),
                child: child,
              ),
              child: controller != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        flipCameraButton,
                        SizedBox(height: 8),
                        FloatingActionButton.large(
                          onPressed: submit,
                          heroTag: null,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Icon(Icons.camera),
                        ),
                      ],
                    )
                  : null,
            )
          : null,
    );
    return Shortcuts(
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.space): UploadTriggerIntent(),
      },
      child: Actions(
        actions: {UploadTriggerIntent: UploadTriggerAction(submit)},
        child: widget,
      ),
    );
  }
}

class UploadTriggerIntent extends Intent {}

class UploadTriggerAction extends Action<UploadTriggerIntent> {
  VoidCallback onUpdate;
  UploadTriggerAction(this.onUpdate);

  @override
  void invoke(_) => onUpdate();
}

class _UploadGuideCornersPainter extends CustomPainter {
  final Color color;
  const _UploadGuideCornersPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 8;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final inset = strokeWidth / 2;
    final maxRadius = math.min(
      (size.width - strokeWidth) / 2,
      (size.height - strokeWidth) / 2,
    );
    final radius = math.min(20.0, maxRadius);
    final armLength = math.min(36.0, maxRadius);

    if (radius <= 0 || armLength <= 0) return;

    final left = inset;
    final top = inset;
    final right = size.width - inset;
    final bottom = size.height - inset;

    canvas.drawLine(
      Offset(left + radius, top),
      Offset(left + armLength, top),
      paint,
    );
    canvas.drawLine(
      Offset(left, top + radius),
      Offset(left, top + armLength),
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(left + radius, top + radius),
        radius: radius,
      ),
      math.pi,
      math.pi / 2,
      false,
      paint,
    );

    canvas.drawLine(
      Offset(right - radius, top),
      Offset(right - armLength, top),
      paint,
    );
    canvas.drawLine(
      Offset(right, top + radius),
      Offset(right, top + armLength),
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(right - radius, top + radius),
        radius: radius,
      ),
      -math.pi / 2,
      math.pi / 2,
      false,
      paint,
    );

    canvas.drawLine(
      Offset(right, bottom - radius),
      Offset(right, bottom - armLength),
      paint,
    );
    canvas.drawLine(
      Offset(right - radius, bottom),
      Offset(right - armLength, bottom),
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(right - radius, bottom - radius),
        radius: radius,
      ),
      0,
      math.pi / 2,
      false,
      paint,
    );

    canvas.drawLine(
      Offset(left, bottom - radius),
      Offset(left, bottom - armLength),
      paint,
    );
    canvas.drawLine(
      Offset(left + radius, bottom),
      Offset(left + armLength, bottom),
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(left + radius, bottom - radius),
        radius: radius,
      ),
      math.pi / 2,
      math.pi / 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_UploadGuideCornersPainter oldDelegate) =>
      color != oldDelegate.color;
}

// MARK: Prediction screen

@RoutePage()
class PredictionScreen extends StatefulWidget {
  final Future<Uint8List>? image;
  final String? prediction;

  const PredictionScreen({
    super.key,
    this.image,
    @QueryParam("p") this.prediction,
  });

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen>
    with TickerProviderStateMixin {
  List<MapEntry<String, double>>? _entries;
  bool? _hasTop;

  bool _noTopReasonEntropy = false;
  bool _noTopReasonConfidence = false;

  AnimationController? _animationImageExtend;
  AnimationController? _animationControllerOthers;

  @override
  void initState() {
    super.initState();
    List<MapEntry<String, double>>? entries;

    if (widget.image == null) {
      if (widget.prediction != null) {
        try {
          final prediction = utf8.decode(base64.decode(widget.prediction!));
          final map = Map<String, Object>.from(jsonDecode(prediction));
          entries = Map<String, double>.from(
            map["prediction"] as Map,
          ).entries.toList();
          if ((entries.fold(0.0, (p, e) => p + e.value) * 100).round() != 100) {
            throw "Invalid prediction values";
          }
        } catch (_) {
          context.replaceRoute(UploadRoute());
        }
      } else {
        context.replaceRoute(UploadRoute());
      }
    }

    _animationImageExtend = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
    _animationControllerOthers = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );

    () async {
      late final bool hasTop;
      Uint8List? queryData;

      await Future.wait([
        entries != null
            ? Future.delayed(Durations.long1)
            : Future.delayed(
                // random two to three seconds
                Duration(seconds: 1) * (math.Random().nextDouble() + 2),
              ),
        () async {
          if (entries == null) {
            final response = await AuthManager.instance.fetch(
              http.MultipartRequest(
                  "POST",
                  Uri.parse("${ApiManager.baseUri}/predict"),
                )
                ..files.add(
                  http.MultipartFile.fromBytes(
                    "",
                    await widget.image!,
                    contentType: http.MediaType.parse("image/png"),
                  ),
                ),
            );
            if (response == null || response.statusCode != 200) {
              throw "Unable to interpret server response";
            }

            queryData = response.bodyBytes;
            entries = Map<String, double>.from(
              jsonDecode(response.body)["prediction"],
            ).entries.toList();
          }

          entries!.sort((a, b) => b.value.compareTo(a.value));

          // https://en.wikipedia.org/wiki/Entropy_(information_theory)
          final n = entries!.length;
          final entropy =
              -entries!.fold(0.0, (sum, x) {
                final val = x.value > 0 ? (x.value * math.log(x.value)) : 0.0;
                return sum + val;
              }) /
              math.log(n);

          entries!.removeWhere((e) => e.value < 0.01);

          final p1 = entries!.first.value;
          final p2 = entries!.length > 1 ? entries![1].value : 0.0;
          final confidenceRatio = p2 > 0
              ? ((p1 * 100) / (p2 * 100))
              : double.infinity;

          hasTop = confidenceRatio >= 2.0 && entropy <= 0.85;
          _noTopReasonEntropy = entropy > 0.85;
          _noTopReasonConfidence = confidenceRatio < 2.0;

          final unlikely = entries!
              .where((e) => e.value <= 0.06 || e.value <= p1 * 0.33)
              .map((e) => e.key)
              .toSet();
          entries!.removeWhere((e) => unlikely.contains(e.key) && hasTop);
        }(),
      ]);

      if (mounted && queryData != null) {
        context.router.navigate(
          PredictionRoute(prediction: base64.encode(queryData!)),
        );
      }

      _entries = entries;
      _hasTop = hasTop;
      if (mounted) setState(() {});

      await Future.delayed(Durations.short3);
      if (hasTop) {
        _animationImageExtend!.forward();
      } else {
        _animationControllerOthers!.forward();
      }
    }().onError((e, _) {
      if (mounted) {
        context.replaceRoute(UploadRoute());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Prediction failed: ${e.toString()}"),
            behavior: SnackBarBehavior.floating,
            width: WindowSizeClass.of(context) > WindowSizeClass.compact
                ? 360
                : null,
            showCloseIcon: true,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final appLocalizations = AppLocalizations.of(context);
    final windowSizeClass = WindowSizeClass.of(context);

    final loading = _entries == null;
    final top = _hasTop == true
        ? PredictionType.values.byName(_entries!.first.key)
        : null;

    final animationImageExtend = CurvedAnimation(
      parent: _animationImageExtend!,
      curve: Curves.easeInOutCubicEmphasized,
    );
    final animationOthers = CurvedAnimation(
      parent: _animationControllerOthers!,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInOutCubic.flipped,
    );

    Widget viewLoading() => Center(
      key: ValueKey("loading"),
      child: LoadingTextFlipThrough(
        texts: [
          appLocalizations.predictionLoadingHint1,
          appLocalizations.predictionLoadingHint2,
          appLocalizations.predictionLoadingHint3,
          appLocalizations.predictionLoadingHint4,
          appLocalizations.predictionLoadingHint5,
          appLocalizations.predictionLoadingHint6,
          appLocalizations.predictionLoadingHint7,
          appLocalizations.predictionLoadingHint8,
          appLocalizations.predictionLoadingHint9,
          appLocalizations.predictionLoadingHint10,
          appLocalizations.predictionLoadingHint11,
          appLocalizations.predictionLoadingHint12,
          appLocalizations.predictionLoadingHint13,
          appLocalizations.predictionLoadingHint14,
          appLocalizations.predictionLoadingHint15,
          appLocalizations.predictionLoadingHint16,
          appLocalizations.predictionLoadingHint17,
          appLocalizations.predictionLoadingHint18,
          appLocalizations.predictionLoadingHint19,
          appLocalizations.predictionLoadingHint20,
          appLocalizations.predictionLoadingHint21,
        ]..shuffle(),
        style: textTheme.titleMedium!.stylizedDialog.copyWith(
          color: colorScheme.outline,
        ),
        duration: Durations.extralong4,
      ),
    );
    Widget viewResult() => ListView(
      padding: windowSizeClass.contentPadding(
        context,
        verticalExcludeTop: true,
      ),
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Card.filled(
                  margin: EdgeInsets.zero,
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(44),
                  ),
                  color: colorScheme.primary,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _hasTop == true
                                      ? appLocalizations
                                            .predictionCategoryPrefix
                                      : appLocalizations
                                            .predictionUnknownPrefix,
                                  style: textTheme.titleSmall!.stylizedDialog
                                      .copyWith(color: colorScheme.onPrimary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  top?.title(appLocalizations) ??
                                      appLocalizations.predictionUnknownSuffix,
                                  style: textTheme.displaySmall!.stylizedDialog
                                      .copyWith(
                                        height: 0.9,
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (windowSizeClass > WindowSizeClass.compact ||
                  _hasTop == false) ...[
                SizedBox(width: 8),
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Card.filled(
                    margin: EdgeInsets.zero,
                    shape: RoundedSuperellipseBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: colorScheme.primaryContainer,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        height: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Icon(
                            _hasTop == true
                                ? Icons.delete_rounded
                                : Icons.question_mark_rounded,
                            color:
                                top?.color(colorScheme.brightness) ??
                                colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              if (_hasTop == true) ...[
                SizedBox(width: 8),
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Card.filled(
                    margin: EdgeInsets.zero,
                    shape: RoundedSuperellipseBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: colorScheme.primaryContainer,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              value: _hasTop == true
                                  ? _entries?.first.value
                                  : 0,
                              backgroundColor: colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.25),
                              color: colorScheme.onPrimaryContainer,
                              strokeWidth: 8,
                            ),
                          ),
                        ),
                        Text(
                          NumberFormat.percentPattern(
                                appLocalizations.localeName,
                              )
                              .format(
                                _hasTop == true ? _entries!.first.value : 0,
                              )
                              .replaceAll(RegExp(r"\s+"), ""),
                          style: textTheme.titleLarge!.stylizedDialog.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (top != null) ...[
          SizedBox(height: 8),
          SizeTransition(
            sizeFactor: animationImageExtend,
            axis: Axis.vertical,
            axisAlignment: 0,
            child: Card.outlined(
              margin: EdgeInsets.zero,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.antiAlias,
              child: top.image(),
            ),
          ),
          SizedBox(height: 8),
          Card.filled(
            margin: EdgeInsets.zero,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            color: colorScheme.secondaryContainer,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Text(
                top.description(appLocalizations),
                style: textTheme.bodyMedium!.stylizedDialog.copyWith(
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Builder(
            builder: (context) {
              final children =
                  [
                        Card.filled(
                          margin: EdgeInsets.zero,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: List.generate(
                                  top
                                          .positiveExamples(appLocalizations)
                                          .split(",")
                                          .length *
                                      2,
                                  (index) {
                                    if (index.isEven) {
                                      return WidgetSpan(
                                        child: Transform.translate(
                                          offset: Offset(-4, 0),
                                          child: Icon(
                                            Icons.check_rounded,
                                            color: colorScheme.onSurfaceVariant,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    } else {
                                      final examples = top
                                          .positiveExamples(appLocalizations)
                                          .split(",");
                                      final example = examples[(index - 1) ~/ 2]
                                          .trim()
                                          .toHalfTitleCase();
                                      return TextSpan(
                                        text:
                                            "$example${index == top.positiveExamples(appLocalizations).split(",").length * 2 - 1 ? "" : "\n"}",
                                      );
                                    }
                                  },
                                ),
                              ),
                              style: textTheme.bodyMedium!.stylizedDialog
                                  .copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8, width: 8),
                        Card.filled(
                          margin: EdgeInsets.zero,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: List.generate(
                                  top
                                          .negativeExamples(appLocalizations)
                                          .split(",")
                                          .length *
                                      2,
                                  (index) {
                                    if (index.isEven) {
                                      return WidgetSpan(
                                        child: Transform.translate(
                                          offset: Offset(-4, 0),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: colorScheme.onSurfaceVariant,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    } else {
                                      final examples = top
                                          .negativeExamples(appLocalizations)
                                          .split(",");
                                      final example = examples[(index - 1) ~/ 2]
                                          .trim()
                                          .toHalfTitleCase();
                                      return TextSpan(
                                        text:
                                            "$example${index == top.positiveExamples(appLocalizations).split(",").length * 2 - 1 ? "" : "\n"}",
                                      );
                                    }
                                  },
                                ),
                              ),
                              style: textTheme.bodyMedium!.stylizedDialog
                                  .copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                        ),
                      ]
                      .map(
                        (e) => e is SizedBox
                            ? e
                            : windowSizeClass > WindowSizeClass.compact
                            ? Expanded(child: e)
                            : SizedBox(width: double.infinity, child: e),
                      )
                      .toList();
              return (windowSizeClass > WindowSizeClass.compact
                  ? Row.new
                  : Column.new)(children: children);
            },
          ),
          if (top.note(appLocalizations) != null) ...[
            SizedBox(height: 8),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Card.filled(
                  margin: EdgeInsets.zero,
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: colorScheme.secondaryContainer,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24 * 2 - 16 + 12,
                      right: 24,
                      top: 20,
                      bottom: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        top.note(appLocalizations)!,
                        style: textTheme.bodyMedium!.stylizedDialog.copyWith(
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-16, 0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: colorScheme.onSecondaryContainer,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
        if (_hasTop == false) ...[
          SizedBox(height: 8),
          Card.filled(
            margin: EdgeInsets.zero,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Builder(
                builder: (context) {
                  final reason = _noTopReasonConfidence && _noTopReasonEntropy
                      ? appLocalizations.predictionNoTopReasonBoth
                      : (_noTopReasonConfidence
                            ? appLocalizations.predictionNoTopReasonTied
                            : appLocalizations.predictionNoTopReasonSpread);
                  return Text(
                    "$reason ${appLocalizations.predictionNoTopTryAgainHint}",
                    style: textTheme.bodyMedium!.stylizedDialog.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        if (_entries!.length > (_hasTop! ? 1 : 0)) ...[
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Transform.translate(
              offset: const Offset(0, 4),
              child: InkWell(
                onTap: () {
                  if (_animationControllerOthers!.isCompleted) {
                    _animationControllerOthers!.reverse();
                  } else {
                    _animationControllerOthers!.forward();
                  }
                },
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal:
                        (Theme.of(
                              context,
                            ).listTileTheme.contentPadding?.horizontal ??
                            8) /
                        2,
                  ),
                  title: Builder(
                    builder: (context) => Text(
                      _hasTop == true
                          ? appLocalizations.predictionOthersPrefix
                          : appLocalizations.predictionOthersNoTopPrefix,
                      style: DefaultTextStyle.of(context)
                          .style
                          .stylizedInterface
                          .copyWith(fontWeight: FontWeight(550)),
                    ),
                  ),
                  dense: true,

                  trailing: RotationTransition(
                    turns: Tween<double>(
                      begin: 0.25,
                      end: 0,
                    ).animate(animationOthers),
                    child: Icon(Icons.expand_more_rounded),
                  ),
                ),
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: animationOthers,
            axis: Axis.vertical,
            axisAlignment: -1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_entries!.length - 1, (index) {
                final entry = _entries![_hasTop! ? index + 1 : index];
                final category = PredictionType.values.byName(entry.key);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Card.outlined(
                    margin: EdgeInsets.zero,
                    shape: RoundedSuperellipseBorder(
                      side: BorderSide(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 20 - 12.8,
                        bottom: 20 - 10.2,
                      ),
                      title: Builder(
                        builder: (context) => Text(
                          category.title(appLocalizations),
                          style: DefaultTextStyle.of(
                            context,
                          ).style.stylizedDialog,
                        ),
                      ),
                      subtitle: Builder(
                        builder: (context) => Text(
                          category.shortDescription(appLocalizations),
                          style: DefaultTextStyle.of(context)
                              .style
                              .stylizedDialog
                              .copyWith(
                                fontSize:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.fontSize! -
                                    2,
                              ),
                        ),
                      ),
                      trailing: Builder(
                        builder: (context) => Transform.translate(
                          offset: Offset(0, 12.8 - 10.2),
                          child: Text(
                            NumberFormat.percentPattern(
                                  appLocalizations.localeName,
                                )
                                .format(entry.value)
                                .replaceAll(RegExp(r"\s+"), ""),
                            style: DefaultTextStyle.of(
                              context,
                            ).style.stylizedDialog,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
          onPressed: () {
            if (context.router.canPop()) {
              context.pop();
            } else {
              context.replaceRoute(UploadRoute());
            }
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          appLocalizations.predictionTitle,
          style: TextTheme.of(context).headlineSmall!.stylizedInterface
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: Durations.medium4,
        transitionBuilder: (child, animation) {
          Widget widget = child;

          if (child.key != const ValueKey("loading")) {
            final curved = CurveTween(curve: Curves.easeInOutCubicEmphasized);
            widget = SlideTransition(
              position: Tween(
                begin: Offset(0.0, 0.06),
                end: Offset.zero,
              ).chain(curved).animate(animation),
              child: Material(child: widget),
            );
          }

          return FadeTransition(opacity: animation, child: widget);
        },
        child: loading ? viewLoading() : viewResult(),
      ),
    );
  }
}

class LoadingTextFlipThrough extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration duration;
  const LoadingTextFlipThrough({
    super.key,
    required this.texts,
    this.style,
    this.duration = const Duration(seconds: 2),
  }) : assert(texts.length > 0, "At least one text must be provided");

  @override
  State<LoadingTextFlipThrough> createState() => _LoadingTextFlipThroughState();
}

class _LoadingTextFlipThroughState extends State<LoadingTextFlipThrough> {
  int index = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (_) {
      index = (index + 1) % widget.texts.length;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.texts[index];
    return AnimatedSwitcher(
      duration: Durations.medium1,
      switchInCurve: Curves.easeInOutSine,
      switchOutCurve: Curves.easeInOutSine.flipped,
      transitionBuilder: (child, animation) {
        final isCurrent = child.key == ValueKey(index);
        return SlideTransition(
          position: Tween(
            begin: isCurrent ? Offset(0, -0.75) : Offset(0, 0.75),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Text(
        key: ValueKey(index),
        current,
        style: widget.style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
