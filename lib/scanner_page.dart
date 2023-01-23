import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final List cameras;
  const CameraView({required this.cameras, Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController controller;
  late List _cameras;
  bool cameraReady = false;
  @override
  void initState() {
    super.initState();
    _cameras = widget.cameras;
    updateController();
  }

  void updateController() {
    log(_cameras.toString());
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraReady = true;
      });
      controller.startImageStream((image) {
        _checkForQRCode(image);
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraReady) {
      return const Text('Detecting cameras');
    }
    return CameraPreview(controller);
  }
}

void _checkForQRCode(CameraImage image) {
  final int w = image.width;
  final int h = image.height;
  List<List<List<int>>> imgArr = [];
  for (int i = 0; i < image.planes.length; i++) {
    List<List<int>> rows = [];
    for (int j = 0; j < h; j++) {
      rows.add(image.planes[i].bytes.sublist(w * j, w * (j + 1)));
    }
    imgArr.add(rows);
  }
  //imgArr = 3xhxw
}

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  List? cameras;
  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      setState(() {
        cameras = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Product'),
      ),
      body: (cameras != null)
          ? CameraView(cameras: cameras!)
          : const Text('Detecting cameras'),
    );
  }
}
