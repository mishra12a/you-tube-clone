import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart'; // Import the uuid package

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadVideo(String videoUrl) async {
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> uploadImage(String imagePath) async {
    // Create a reference to the image in Firebase Storage
    final reference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
    // Upload the image file
    await reference.putFile(File(imagePath));
    // Get the download URL for the uploaded image
    final downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveVideoData({
    required String videoDownloadUrl,
    required String thumbnail,
    required String catagory,
    required String profile_pic,
    required String title,
    required String user_name,
    required String views,
    required String like_count,
  }) async {
    final uuid1 = generateUniqueUUID();
    final uuid2 = generateUniqueUUID();
    await _firestore.collection('/Video_Info').add({
      "id": uuid2,
      "thumb_nail": thumbnail,
      "catagory": catagory,
      "location": "Denmark",
      "profile_pic": profile_pic,
      "title": title,
      "views": views,
      "upload_date": DateTime.now().toString(),
      "like_count": like_count,
      "user_name": user_name,
      "unlike_count": "0",
      "video_url": videoDownloadUrl
    });
  }
}

String generateUniqueUUID() {
  final uuid = Uuid(); // Create a Uuid instance
  return uuid.v4(); // Generate a version 4 (random) UUID
}
