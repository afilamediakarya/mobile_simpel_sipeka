// ignore_for_file: unused_field, prefer_final_fields

import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/pages/tambah/swafoto/confirm_swafoto_page.dart';

class CameraSwafotoPage extends StatefulWidget {
  const CameraSwafotoPage({super.key, required this.cameras});

  final List<CameraDescription>? cameras;

  @override
  State<CameraSwafotoPage> createState() => _CameraSwafotoPageState();
}

class _CameraSwafotoPageState extends State<CameraSwafotoPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![1]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmSwafotoPage(picture: picture)));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCameraPageColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/ic_close.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                  Image.asset(
                    "assets/ic_flash.png",
                    height: 24,
                    width: 24,
                  )
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Swafoto",
                        style: whiteTextStyle.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Seluruh wajah terlihat dengan jelas dan\nmenghadap kamera",
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                SizedBox(
                  height: 339,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Transform.scale(
                        scale: 3,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 0.5,
                            child: CameraPreview(_cameraController),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/ic_camera_frame.png",
                          height: 339,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
            const SizedBox(
              height: 64,
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: takePicture,
                  child: Center(
                    child: Image.asset(
                      "assets/ic_camera_button.png",
                      height: 64,
                      width: 64,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 56, top: 4),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/ic_change_camera.png",
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            )
          ],
        ),
      ),
    );
  }
}
