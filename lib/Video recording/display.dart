import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickVideo() async {
  final picker = ImagePicker();
  XFile? videoFile;
  try {
    videoFile = await picker.pickVideo(source: ImageSource.camera
    );
    return videoFile!.path;
  } catch (e) {
    print('Error: $e');
  }
}

pickimage() async {
  final picker = ImagePicker();
  XFile? ImageFile;
  try {
    ImageFile = await picker.pickImage(source: ImageSource.gallery);
    return ImageFile!.path;
  } catch (e) {
    print('Error: $e');
  }
}

// class Display extends StatefulWidget {
//   final File videoFile;
//   final String videoPath;
//    Display({super.key, required this.videoFile, required this.videoPath});

//   @override
//   State<Display> createState() => _DisplayState();
// }

// class _DisplayState extends State<Display> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
