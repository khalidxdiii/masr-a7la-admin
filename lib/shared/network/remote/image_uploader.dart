import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUploader {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference = _storage.ref().child(fileName);
    final UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.then((p0) {
      debugPrint('finish upload image');
    });
    final String url = await storageReference.getDownloadURL();
    return url;
  }

  Future<bool> storeProblem({
    String? url,
    required String titleDisc,
    required String problemDisc,
    required String locationDisc,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('problems').add({
        'image_url': url,
        'title_disc': titleDisc,
        'problem_disc': problemDisc,
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': Timestamp.now(),
        'locationDisc': locationDisc,
      });
      debugPrint('finish upload problem');
      return true;
    } catch (e) {
      return false;
    }
  }
}
