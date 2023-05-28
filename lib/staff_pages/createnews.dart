import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';
import 'package:k9k10connect/storage_service.dart';

class CreateNews extends StatefulWidget {
  CreateNews({Key? key}) : super(key: key);
  //const CreateNews ({Key? key}) : super(key: key);

  @override
  CreateNewsInsertState createState() => CreateNewsInsertState();
}

class CreateNewsInsertState extends State<CreateNews> {
  var titleController = new TextEditingController();
  var descController = new TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
  }

  //final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              'Create news ',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: _margin(),
            padding: EdgeInsets.symmetric(),
            child: TextFormField(
                controller: titleController,
                enableInteractiveSelection:
                    false, // will disable paste operation
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty ? 'Invalid ' : null,
                decoration: kinputDecoration('Title', null)),
          ),
          Container(
            margin: _margin(),
            child: TextFormField(
              controller: descController,
              enableInteractiveSelection: false, // will disable paste operation
              keyboardType: TextInputType.text,
              validator: (val) => val!.isEmpty ? 'Invalid ' : null,
              decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 10, bottom: 150),
                  border: const OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg'],
                  );
                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No file selected'),
                      ),
                    );
                    return null;
                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;
                  // print(path);
                  // print(fileName);

                  storage
                      .uploadFile(path, fileName)
                      .then((value) => print('Done'));
                },
                icon: Icon(
                  color: Colors.brown,
                  Icons.upload_file,
                  size: 30,
                ),
                label: Text(
                  'Upload',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 270),
            child: ElevatedButton(
              onPressed: () {
                createNews(
                    titleController.text.trim(), descController.text.trim());
                Navigator.pop(context);
              },
              child: Text('POST'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange[100],
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future createNews(String title, String description) async {
    await FirebaseFirestore.instance.collection('news').add({
      'title': title,
      'description': description,
    });
  }

//   void insertData(String title, String description) {
//     databaseRef.child("path").set({
//       'title': title,
//       'description': description,
//     });
//     titleController.clear();
//     descController.clear();
//   }
// }

// class News {
//   String id;
//   String title;
//   String description;
//   News({
//     this.id = "",
//     required this.title,
//     required this.description,
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'description': description,
//       };
// }

  InputDecoration kinputDecoration(String label, SuffixIcon) {
    return InputDecoration(
        //labelStyle: TextStyle(fontSize: 20),
        suffixIcon: SuffixIcon,
        labelText: label,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid)));
  }

  EdgeInsetsGeometry _margin() {
    return EdgeInsets.only(left: 20, right: 20, top: 10);
  }

  EdgeInsetsGeometry _padding() {
    return EdgeInsets.only(left: 20, top: 20);
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('News'),
      actions: <Widget>[
        IconButton(onPressed: null, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
