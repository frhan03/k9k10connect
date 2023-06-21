import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'report.dart';

class ViewReport extends StatefulWidget {
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  Future<void> generatePdf(List<QueryDocumentSnapshot> reports) async {
    final pdf = pw.Document();

    for (final report in reports) {
      final location = report['location'];
      final category = report['category'];
      final description = report['description'];
      final createdAt = report['createdAt'].toDate();
      final status = report['status'];
      final imageUrl = report['image'];

      final imageBytes = await http.readBytes(Uri.parse(imageUrl));
      final imageProvider = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Header(level: 0, text: 'View Report'),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Location: $location'),
                pw.Text('Category: $category'),
                pw.Text('Description: $description'),
                pw.Text('Created At: ${createdAt.toString()}'),
                pw.Text('Status: $status'),
                pw.SizedBox(height: 10),
                pw.Image(imageProvider),
                pw.SizedBox(height: 10),
              ],
            ),
          ],
        ),
      );
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/reports.pdf';
    final file = await File(filePath).writeAsBytes(await pdf.save());

    // Open the PDF file
    OpenFile.open(filePath);
  }

  Future<void> deleteReport(String reportId) async {
    await FirebaseFirestore.instance
        .collection('report')
        .doc(reportId)
        .delete();
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
                final createdAt = report['createdAt'].toDate();
                final status = report['status'];
                final imageUrl = report['image'];

                bool canDelete = status == 'Resolved';

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
                  trailing: canDelete
                      ? IconButton(
                          onPressed: () async {
                            bool deleteConfirmed = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content:
                                      Text('Are you sure you want to delete?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(true); // Confirm deletion
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(false); // Cancel deletion
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (deleteConfirmed == true) {
                              await deleteReport(reportId); // Delete the report
                            }
                          },
                          icon: Icon(Icons.delete),
                        )
                      : null,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final querySnapshot =
                  await FirebaseFirestore.instance.collection('report').get();
              final reports = querySnapshot.docs.toList();

              await generatePdf(reports);
            },
            child: Icon(Icons.picture_as_pdf),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => report()),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
