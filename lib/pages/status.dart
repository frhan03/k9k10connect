import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/staff_pages/status_staff.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Color(0xFFD7CCC8), useMaterial3: true),
      home: const MyStatusPage(),
    );
  }
}

class MyStatusPage extends StatefulWidget {
  const MyStatusPage({Key? key}) : super(key: key);

  @override
  _MyStatusPageState createState() => _MyStatusPageState();
}

class _MyStatusPageState extends State<MyStatusPage> {
  late User? currentUser;
  String? displayName;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserDisplayName();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    print('Current user: $user');
    setState(() {
      currentUser = user;
    });
  }

  void getUserDisplayName() async {
    print('Fetching display name');
    if (currentUser != null) {
      String uid = currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String? firstName = snapshot.data()?['first name'];
      String? lastName = snapshot.data()?['last name'];
      String? displayName = '$firstName $lastName';
      setState(() {
        this.displayName = displayName;
        print('Updated display name: $displayName');
      });
    }
  }

  Future<String> getDisplayNameFromUID(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    String? firstName = snapshot.data()?['first name'];
    String? lastName = snapshot.data()?['last name'];
    String? displayName = '$firstName $lastName';
    return displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('report').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final reports = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index].data() as Map<String, dynamic>;
              String uid = report['uid'];

              return FutureBuilder<String>(
                future: getDisplayNameFromUID(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text('Error occurred.'),
                    );
                  }

                  String displayName = snapshot.data ?? '';

                  return ListTile(
                    title: Text('Name: $displayName'),
                    textColor: Colors.black,
                    subtitle: Text(
                        'Location: ${report['location']} \nCategory Damage:${report['category']} \nDescription: ${report['description']}'),
                    isThreeLine: true,
                    tileColor: Colors.grey[300],
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: Card(
                            color: _getStatusColor(report['status']),
                            child: Center(
                              child: Text(
                                report['status'],
                                style: TextStyle(
                                  color: _getStatusTextColor(report['status']),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (report['status'] == 'Resolved') {
                              bool deleteConfirmed = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text(
                                        'Are you sure you want to delete?'),
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
                                // Delete the report
                                FirebaseFirestore.instance
                                    .collection('report')
                                    .doc(reports[index].id)
                                    .delete();
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Cannot Delete'),
                                    content: Text(
                                        'You can only delete when  is resolved.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final updatedReport = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatusStaffPage(
                            report: report,
                            displayName: displayName,
                          ),
                        ),
                      );
                      if (updatedReport != null) {
                        // Update the report with the returned updated report
                        FirebaseFirestore.instance
                            .collection('report')
                            .doc(reports[index].id)
                            .update(updatedReport);
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Color.fromARGB(255, 186, 151, 139);
      case 'In-action':
        return Color.fromARGB(255, 68, 11, 27);
      case 'Resolved':
        return Color.fromARGB(180, 245, 245, 245);
      default:
        return Colors.grey[300]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pending':
      case 'In-action':
        return Colors.white;
      case 'Resolved':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Status'),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
