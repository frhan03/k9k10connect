 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';
import 'package:k9k10connect/staff_pages/editstatus_staff.dart';

class StatusStaffPage extends StatelessWidget {
  const StatusStaffPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Color(0xFFD7CCC8), useMaterial3: true),
      home: const MyStatusStaffPage(),
    );
  }
}

class MyStatusStaffPage extends StatefulWidget {
  const MyStatusStaffPage({Key? key}) : super(key: key);

  @override
  _MyStatusStaffPageState createState() => _MyStatusStaffPageState();
}

class _MyStatusStaffPageState extends State<MyStatusStaffPage> {
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
    drawer: MyDrawer(),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('report').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final reports = snapshot.data!.docs;

        return ListView.separated(
          itemCount: reports.length,
          separatorBuilder: (BuildContext context, index){
            return Container(
              height: 2,
              color: Colors.transparent,
            );
          },
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
                          bool deleteConfirmed = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Are you sure you want to delete?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true); // Confirm deletion
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false); // Cancel deletion
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
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final updatedReport = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditStatusStaffPage(
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
