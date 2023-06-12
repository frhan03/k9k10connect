
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/staff_pages/newspage_staff.dart';

class EditNewsPage extends StatefulWidget {
  final Map<String, dynamic> newsData;
  final String formattedDate;
  final String documentId;
  final Function(Map<String, dynamic> updatedNewsData) onUpdate;

  EditNewsPage({Key? key, required this.newsData, required this.formattedDate, required this.documentId, required this.onUpdate});

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  final _formKey = GlobalKey<FormState>();

  // Updating News
  CollectionReference news = FirebaseFirestore.instance.collection('news');

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState(){
    super.initState();
    var data = widget.newsData;
    titleController = TextEditingController(text: data['title']);
    descriptionController = TextEditingController(text: data['description']);
  }

  @override
  void dispose(){
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    var title = titleController.text;
    var description = descriptionController.text;
    try{
      await news.doc(widget.documentId).update({
        'title': title,
        'description': description,
      });
      print("News Updated");

      widget.onUpdate({
        'title': title,
        'description': description,
      });
      Navigator.pop(context);
    } catch (error) {
      print("Failed to update news: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        // Getting Specific Data by ID
        child: StreamBuilder<DocumentSnapshot>(
          stream: news.doc(widget.documentId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            var data = snapshot.data!.data() as Map<String, dynamic>?;

            if (data == null) {
              // Handle the case when data is null
              return Text('No data available');
            }

            titleController.text = data['title'];
            descriptionController.text = data['description'];

        return ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: titleController,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Title: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: descriptionController,
                  autofocus: false,
                  obscureText: false,
                  maxLines: 18,
                  decoration: InputDecoration(
                    labelText: 'Description: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            updateUser();
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 201, 203, 187),
                          onPrimary: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _showDeleteConfirmationDialog(
                              context, widget.documentId);
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 71, 18, 42),
                          onPrimary: Color.fromARGB(255, 201, 203, 187),
                        ),
                      ),
                    ),
                  ],     
                ),
              ),
            ],
          );  
        },
      ),
    ),
    );
  }
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

void _showDeleteConfirmationDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete News'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black
          ),
          backgroundColor: Color.fromARGB(255, 246, 247, 249),
          content: Text('Are you sure you want to delete?'),
          contentTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          actions: <Widget>[
             TextButton(
              child: Text('YES'),
              onPressed: () {
                _deleteNewsItem(documentId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsStaffPage()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 71, 18, 42),
              ),
            ),
           
          ],
        );
      },
    );
  }

  void _deleteNewsItem(String documentId) {
    FirebaseFirestore.instance.collection('news').doc(documentId).delete();
  }
