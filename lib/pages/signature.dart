import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constatnt/Global.dart';

class Signature extends StatefulWidget {
  const Signature({Key? key}) : super(key: key);

  @override
  State<Signature> createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  final ImagePicker _picker = ImagePicker();
  TextStyle tStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Signature",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        child: InkWell(
          onTap: () async {
            XFile? pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);
            setState(() {
              Global.SignatureImage = File(pickedFile!.path);
            });
          },
          child: Center(
            child: DottedBorder(
              padding: EdgeInsets.all(5),
              borderType: BorderType.Rect,
              color: AppColors.primaryColor,
              child: SizedBox(
                height: 200,
                width: 300,
                child: (Global.SignatureImage != null)
                    ? Image.file(
                        Global.SignatureImage!,
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add your Signature",
                            style: tStyle,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
