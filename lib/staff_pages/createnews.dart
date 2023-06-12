import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class CreateNews extends StatefulWidget {
  CreateNews({Key? key}) : super(key: key);

  @override
  _CreateNewsState createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  String imageUrl = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
      File imageFile = File(pickedFile.path);
      String uploadedImageUrl = await uploadImageToFirebase(imageFile);
      setState(() {
        imageUrl = uploadedImageUrl;
      });
    }
  }

  Future<void> createNews(String title, String description, DateTime createdAt,
      String imageUrl) async {
    await FirebaseFirestore.instance.collection('news').add({
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'image': imageUrl,
    });
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = Path.basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('news_images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void deleteFormData() {
    setState(() {
      _titleController.text = '';
      _descController.text = '';
      imageUrl = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create News'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16),
            if (imageUrl.isNotEmpty) Image.file(File(imageUrl)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please upload an image')));
                  return;
                }

                String title = _titleController.text;
                String description = _descController.text;
                DateTime createdAt = DateTime.now();

                await createNews(title, description, createdAt, imageUrl);
                deleteFormData();
                Navigator.of(context).pop();
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}