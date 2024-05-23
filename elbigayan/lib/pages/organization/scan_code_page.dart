import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  File? image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemp = File(image.path);

    setState(() {
      this.image = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 40,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.blue[900],
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 24,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
            ),
          ),
        ],
        title: const Text(
          'Scan Code',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            debugPrint("Barcode found! ${barcode.rawValue}");
            // capture.stop();
          }
          if (image != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      barcodes.first.rawValue ?? "",
                    ),
                    content: Image(image: MemoryImage(image)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .pop(); 
                          await getImage();
                        },
                        child:  Text('Link Donation', style: TextStyle(color: Colors.blue[900]),),
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
