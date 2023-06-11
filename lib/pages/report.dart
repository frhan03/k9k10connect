import 'dart:io';

import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';

import 'viewReport.dart';

class report extends StatefulWidget {
const report({Key? key}) : super(key: key);

@override
_reportState createState() => _reportState();
}

class _reportState extends State<report> {
String? _categoryValue;
String imageUrl = '';
var _location;
var _description;

TextEditingController _locationController = TextEditingController();
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

Future<void> createReport(
String location,
String category,
String description,
String imageUrl,
DateTime createdAt,
String status) async {
//get the current user from firebase auth
User? user = FirebaseAuth.instance.currentUser;
if (user != null) {
String uid = user.uid;
await FirebaseFirestore.instance.collection('report').add({
'uid': uid,
'location': location,
'category': category,
'description': description,
'image': imageUrl,
'createdAt': createdAt,
'status': status,
});
}
}

Future<String> uploadImageToFirebase(File imageFile) async {
String fileName = Path.basename(imageFile.path);
Reference firebaseStorageRef =
FirebaseStorage.instance.ref().child('report_images/$fileName');
UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
TaskSnapshot taskSnapshot = await uploadTask;
String imageUrl = await taskSnapshot.ref.getDownloadURL();
return imageUrl;
}

void deleteFormData() {
setState(() {
_locationController.text = '';
_descController.text = '';
imageUrl = '';
_categoryValue = '';
});
}

void _submitReport() {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
contentPadding: const EdgeInsets.all(20.0),
content: Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Text('Submitted'),
TextButton(
onPressed: () {
Navigator.push(context,
MaterialPageRoute(builder: (context) => ViewReport()));
},
child: Text('Ok'),
),
],
),
),
);
},
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: _buildAppBar(),
drawer: MyDrawer(),
body: ListView(
padding: EdgeInsets.all(16.0),
children: [
ListTile(
title: Text('Location'),
),
ListTile(
title: TextField(
controller: _locationController,
decoration: InputDecoration(
hintText: 'Enter location',
border: OutlineInputBorder(),
),
),
),
ListTile(
title: Text('Damage Category'),
),
ListTile(
title: Row(
children: [
Expanded(
child: RadioListTile<String>(
title: Text('Civil damage'),
value: 'Civil damage',
groupValue: _categoryValue,
onChanged: (value) {
setState(() {
_categoryValue = value;
});
},
),
),
Expanded(
child: RadioListTile<String>(
title: Text('Electrical damage'),
value: 'Electrical damage',
groupValue: _categoryValue,
onChanged: (value) {
setState(() {
_categoryValue = value;
});
},
),
),
],
),
),
ListTile(
title: Row(
children: [
Expanded(
child: RadioListTile<String>(
title: Text('Furniture damage'),
value: 'Furniture damage',
groupValue: _categoryValue,
onChanged: (value) {
setState(() {
_categoryValue = value;
});
},
),
),
Expanded(
child: RadioListTile<String>(
title: Text('Others'),
value: 'Others',
groupValue: _categoryValue,
onChanged: (value) {
setState(() {
_categoryValue = value;
});
},
),
),
],
),
),
ListTile(
title: Text('Description'),
),
ListTile(
title: TextField(
controller: _descController,
decoration: InputDecoration(
hintText: 'Enter description',
border: OutlineInputBorder(),
),
),
),
ListTile(
title: Text('Damage Photos'),
),
ListTile(
title: Row(
children: [
Expanded(
child: TextButton.icon(
onPressed: () {
getImage();
},
icon: Icon(Icons.attach_file),
label: Text('Add file'),
),
),
if (imageUrl.isNotEmpty) Image.file(File(imageUrl)),
],
),
),
ListTile(
title: ElevatedButton(
onPressed: () async {
if (imageUrl.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Please upload an image')));
return;
}
            String location = _locationController.text;
            String description = _descController.text;
            DateTime createdAt = DateTime.now();
            String? category = _categoryValue;
            String status = "Pending"; // Change status to "Pending"
            await createReport(location, category!, description, imageUrl,
                createdAt, status);
            deleteFormData();
            _submitReport();
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ),
    ],
  ),
);
}

void _doNothing() {}

AppBar _buildAppBar() {
return AppBar(
centerTitle: true,
title: Text('Report'),
actions: <Widget>[
IconButton(onPressed: _doNothing, icon: Icon(Icons.notifications)),
],
);
}
}
