import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/radio_dialog.dart';
import '../widgets/status_modal.dart';

@RoutePage()
class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with WidgetsBindingObserver {
  int cameraIndex = 0;
  CameraController? controller;

  bool error = false;
  bool noCamera = false;

  @override
  void initState() {
    super.initState();
    camerasInitialize().then((_) => loadStoredCamera());
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

    await controller!.initialize().onError((_, _) {
      error = true;
      if (mounted) setState(() {});
    });
    if (!error && mounted) setState(() {});
  }

  void switchCamera() async {
    final availableCameras = await cameras.future;

    if (!mounted) return;
    final selection = await showRadioDialog(
      context: context,
      title: AppLocalizations.of(context).selectCamera,
      initialValue: availableCameras[cameraIndex],
      items: availableCameras,
      titleGenerator: (item) => item.name,
      subtitleGenerator: (item) =>
          "${switch (item.lensDirection) {
            CameraLensDirection.back => AppLocalizations.of(context).selectCameraDescriptionBack,
            CameraLensDirection.front => AppLocalizations.of(context).selectCameraDescriptionFront,
            CameraLensDirection.external => AppLocalizations.of(context).selectCameraDescriptionExternal,
          }} (${item.sensorOrientation}°)",
      iconGenerator: (item) => Icon(switch (item.lensDirection) {
        CameraLensDirection.back => Icons.camera_rear,
        CameraLensDirection.front => Icons.camera_front,
        CameraLensDirection.external => Icons.outbond_outlined,
      }),
    );
    if (selection == null) return;

    final tmpIndex = availableCameras.indexOf(selection);
    if (tmpIndex == cameraIndex) return;

    cameraIndex = tmpIndex;
    prefs.setInt("camera", cameraIndex);
    controller?.dispose();
    controller = null;

    if (mounted) setState(() {});
    await _initializeCameraController(selection);
  }

  void submit() async {
    final completer = Completer<void>();
    http.Response? response;
    showStatusModal(
      context: context,
      completer: completer,
      barrierDismissible: false,
      failureDetailsGenerator: () {
        try {
          if (jsonDecode(response!.body) case {"error": String errorMessage}) {
            return errorMessage;
          }
        } catch (_) {}
        return "Status code: ${response?.statusCode ?? "<unavailable>"}\n${response?.body}"
            .trim();
      },
    );

    final imageRaw = await controller!.takePicture();
    await controller!.pausePreview();
    var image = img.decodeImage(await imageRaw.readAsBytes())!;
    if (!mounted) return;

    response = await AuthManager.instance.fetch(
      http.MultipartRequest("POST", Uri.parse("${ApiManager.baseUri}/predict"))
        ..files.add(
          http.MultipartFile.fromBytes(
            "",
            img.encodePng(image),
            contentType: http.MediaType.parse("image/png"),
          ),
        ),
    );
    if (response == null || response.statusCode != 200) {
      completer.completeError("Prediction failed");
      controller!.resumePreview();
      return;
    }
    completer.complete();
    await controller!.resumePreview();
    await Future.delayed(
      Duration(milliseconds: 750),
    ); // wait for modal to close

    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => UploadResultModal(
        prediction: Map<String, double>.from(
          jsonDecode(response!.body)["prediction"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget previewWidget() => Card.outlined(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: CameraPreview(controller!),
        ),
      ),
    );
    Widget errorWidget() => ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.device_unknown, size: 48),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).cameraNotFound,
            textAlign: TextAlign.center,
            style: TextTheme.of(context).headlineSmall!.copyWith(height: 1),
          ),
          Text(
            camerasPermissionDenied
                ? AppLocalizations.of(context).cameraErrorPermission
                : AppLocalizations.of(context).cameraErrorUnavailable,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: 16),
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
                label: Text(AppLocalizations.of(context).retry),
                icon: Icon(Icons.refresh),
              ),
        ],
      ),
    );

    final widget = Scaffold(
      resizeToAvoidBottomInset: false,
      body: !error
          ? controller != null && controller!.value.isInitialized
                ? Center(heightFactor: 1.2, child: previewWidget())
                : Center(child: CircularProgressIndicator())
          : noCamera
          ? Center(child: errorWidget())
          : Center(child: Icon(Icons.error_outline, size: 48)),
      floatingActionButton: AnimatedSwitcher(
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
                  FloatingActionButton(
                    onPressed: switchCamera,
                    child: AnimatedSwitcher(
                      duration: Durations.medium1,
                      switchInCurve: Curves.easeInOutCubicEmphasized,
                      switchOutCurve: Curves.easeInOutCubicEmphasized.flipped,
                      child: Icon(
                        switch (controller!.description.lensDirection) {
                          CameraLensDirection.back => Icons.camera_rear,
                          CameraLensDirection.front => Icons.camera_front,
                          CameraLensDirection.external => Icons.cameraswitch,
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  FloatingActionButton.large(
                    onPressed: submit,
                    child: Icon(Icons.camera),
                  ),
                ],
              )
            : null,
      ),
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

class UploadResultModal extends StatefulWidget {
  final Map<String, double> prediction;
  const UploadResultModal({super.key, required this.prediction});

  @override
  State<UploadResultModal> createState() => _UploadResultModalState();
}

class _UploadResultModalState extends State<UploadResultModal> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    Widget divider = Padding(padding: EdgeInsets.all(8), child: Divider());

    var entriesRaw = widget.prediction.entries
        .where((e) => e.value > 0.05)
        .toList();
    if (entriesRaw.isEmpty) entriesRaw = widget.prediction.entries.toList();
    final entries = (entriesRaw..sort((a, b) => b.value.compareTo(a.value)))
        .take(50); // TODO: adjust max entries if needed

    return DraggableScrollableSheet(
      minChildSize: 0.4,
      maxChildSize: 0.8,
      initialChildSize: 0.65,
      expand: false,
      builder: (_, controller) => ListView(
        controller: controller,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 16, right: 16),
        children: [
          SizedBox(height: 16),
          ListTile(
            title: Text(
              appLocalizations.resultTitle,
              style: TextTheme.of(context).headlineSmall,
            ),
          ),
          SizedBox(height: 4),
          ...entries
              .map((e) {
                final isTop = e == entries.first && e.value > 0.35;
                return [
                  UploadResultWidget(
                    prediction: e.key,
                    probability: e.value,
                    isTop: isTop,
                  ),
                  if (isTop)
                    Padding(padding: EdgeInsets.only(top: 20), child: divider),
                ];
              })
              .expand((e) => e),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class UploadResultWidget extends StatefulWidget {
  final String prediction;
  final double probability;
  final bool isTop;
  const UploadResultWidget({
    super.key,
    required this.prediction,
    required this.probability,
    required this.isTop,
  });

  @override
  State<UploadResultWidget> createState() => _UploadResultWidgetState();
}

class _UploadResultWidgetState extends State<UploadResultWidget>
    with SingleTickerProviderStateMixin {
  late final PredictionType _predictionType;
  late final AnimationController _expandController;

  @override
  void initState() {
    super.initState();
    _predictionType = PredictionType.values.firstWhere(
      (type) => type.apiString == widget.prediction,
      orElse: () => PredictionType.residualWaste,
    );
    _expandController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
      value: widget.isTop ? 1.0 : 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOutCubicEmphasized,
      reverseCurve: Curves.easeInOutCubicEmphasized.flipped,
    );

    final positiveExamples = _predictionType
        .examples(appLocalizations)
        .split(",")
        .map((e) => e.trim().toHalfTitleCase())
        .toList();
    final negativeExamples = _predictionType
        .negativeExamples(appLocalizations)
        .split(",")
        .map((e) => e.trim().toHalfTitleCase())
        .toList();

    final details = () {
      final brightness = Theme.brightnessOf(context);
      final positiveColorScheme = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: brightness,
        ),
      );
      final negativeColorScheme = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: brightness,
        ),
      );
      Widget chip(String example) => Builder(
        builder: (context) {
          final colorScheme = ColorScheme.of(context);
          return ActionChip(
            onPressed: () => launchUrl(
              Uri.parse(
                "https://google.com/search?q=${Uri.encodeComponent("$example ${appLocalizations.predictionExampleSearchSuffix}")}",
              ),
            ),
            label: Text(
              example,
              style: DefaultTextStyle.of(
                context,
              ).style.copyWith(color: colorScheme.onSecondaryContainer),
            ),
            backgroundColor: colorScheme.secondaryContainer,
          );
        },
      );
      return ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isTop)
              Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.only(right: 8, top: 2),
                child: CustomPaint(
                  painter: _UploadResultWidgetHierarchy(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: positiveExamples
                          .map(
                            (example) => Theme(
                              data: positiveColorScheme,
                              child: chip(example),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 4),
                  Flexible(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: negativeExamples
                          .map(
                            (e) => Theme(
                              data: negativeColorScheme,
                              child: chip(e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }();
    return DecoratedBox(
      decoration: BoxDecoration(
        border: widget.isTop
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.isTop ? 8 : 12),
        onTap: !widget.isTop
            ? () {
                if (_expandController.isCompleted) {
                  _expandController.reverse();
                } else {
                  _expandController.forward();
                }
              }
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              selected: widget.isTop,
              contentPadding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 2,
                top: 2,
              ),
              title: Text(_predictionType.title(appLocalizations)),
              subtitle: Text(_predictionType.description(appLocalizations)),
              trailing: Builder(
                builder: (context) => Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(value: widget.probability),
                    Text(
                      NumberFormat.percentPattern(appLocalizations.localeName)
                          .format(widget.probability)
                          .replaceAll(RegExp(r"\s+"), ""),
                      style: DefaultTextStyle.of(
                        context,
                      ).style.copyWith(color: ColorScheme.of(context).primary),
                    ),
                  ],
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: details,
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadResultWidgetHierarchy extends CustomPainter {
  final Color color;
  _UploadResultWidgetHierarchy({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double offset = 0.5;
    const double radius = 8.0;

    final path = Path()
      ..moveTo(offset, 0)
      ..lineTo(offset, size.height - radius)
      ..quadraticBezierTo(
        offset,
        size.height - offset,
        radius,
        size.height - offset,
      )
      ..lineTo(size.width, size.height - offset);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_UploadResultWidgetHierarchy oldDelegate) =>
      color != oldDelegate.color;
}
