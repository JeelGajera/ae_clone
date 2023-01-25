import 'package:ae_clone/controller/webview/qrscanner_overlay.dart';
import 'package:ae_clone/views/webview_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../utils/colors.dart';

class MobileScannerPage extends StatefulWidget {
  const MobileScannerPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MobileScannerPageState createState() => _MobileScannerPageState();
}

class _MobileScannerPageState extends State<MobileScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  
  String? barcodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        backgroundColor: MyColors.prColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () {
              cameraController.toggleTorch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () {
              cameraController.switchCamera();
            },
          ),
        ],
      ),
      body: InkWell(
        onTap: () {
          if (barcodeData != null) {
            // cameraController.stop();
            Get.to(() => WebViewPage(url: barcodeData!));
          }
        },
        child: Stack(
          children: [
            MobileScanner(
                allowDuplicates: false,
                controller: cameraController,
                onDetect: (barcode, args) {
                  setState(() {
                    barcodeData = barcode.rawValue;
                  });
                  // print("This is Qr Content ======> ${barcodeData}");
                }),
            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(0.5),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      barcodeData == null ? "Scan QR Code" : "Open up the link",
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: const TextStyle(
                        color: MyColors.aeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
