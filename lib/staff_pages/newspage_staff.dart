import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k9k10connect/staff_pages/createnews.dart';

import '../staffdrawer.dart';

class NewsStaffPage extends StatelessWidget {
  NewsStaffPage({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('news');
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyStaffDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            List<Map<String, dynamic>> items =
                documents.map((e) => e.data() as Map<String, dynamic>).toList();

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> thisItem = items[index];
                DateTime? createdAt = thisItem['createdAt']?.toDate();
                String formattedDate = createdAt != null
                    ? DateFormat('yyyy-MM-dd HH:mm').format(createdAt)
                    : 'N/A';

                return ListTile(
                  title: Text('${thisItem['title']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${thisItem['description']}'),
                      Text('Created at: $formattedDate'),
                    ],
                  ),
                 leading: Container(
  height: 80,
  width: 80,
  child: thisItem.containsKey('image')
      ? Image.network(
          '${thisItem['image']}',
          fit: BoxFit.cover,
        )
      : Container(),
),

                  onTap: () {
                    _showDeleteConfirmationDialog(
                        context, snapshot.data!.docs[index].id);
                  },
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateNews()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete News'),
          content: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                _deleteNewsItem(documentId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNewsItem(String documentId) {
    FirebaseFirestore.instance.collection('news').doc(documentId).delete();
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
