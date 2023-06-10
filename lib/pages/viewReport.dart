
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'report.dart'; 

class ViewReport extends StatefulWidget {
@override
_ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
Future<void> deleteReport(String reportId) async {
await FirebaseFirestore.instance.collection('report').doc(reportId).delete();
}

Future<void> confirmDeleteReport(String reportId) async {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: Text('Confirm Delete'),
content: Text('Are you sure you want to delete this report?'),
actions: <Widget>[
TextButton(
child: Text('Yes'),
onPressed: () async {
await deleteReport(reportId);
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

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('View Report'),
),
body: StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance.collection('report').snapshots(),
builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
if (snapshot.hasData) {
final reports = snapshot.data!.docs;
        return ListView.builder(
          itemCount: reports.length,
          itemBuilder: (BuildContext context, int index) {
            final report = reports[index];

            final reportId = report.id;
            final location = report['location'];
            final category = report['category'];
            final description = report['description'];
            final imageUrl = report['image'];
            final createdAt = report['createdAt'].toDate();
            final status = report['status'];

            return ListTile(
              title: Text('Location: $location'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: $category'),
                  Text('Description: $description'),
                  Text('Created At: ${createdAt.toString()}'),
                  Text('Status: $status'),
                ],
              ),
              leading: Image.network(imageUrl),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => confirmDeleteReport(reportId),
              ),
            );
          },
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return CircularProgressIndicator();
      }
    },
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => report()), // Navigate to report.dart
      );
    },
    child: Icon(Icons.add),
  ),
);
}
}
