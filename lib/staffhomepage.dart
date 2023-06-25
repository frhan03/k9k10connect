import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/pages/profile.dart';
import 'package:k9k10connect/screens/signin_screen.dart';
import 'package:k9k10connect/staff_pages/newspage_staff.dart';
import 'package:k9k10connect/staff_pages/status_staff.dart';
import 'package:k9k10connect/staffdrawer.dart';

import 'pages/viewReport.dart';

class StaffHomepage extends StatelessWidget {
  const StaffHomepage({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: Color(0xff6750a4), useMaterial3: true
          ),
      home: const MyStaffHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyStaffHomePage extends StatefulWidget {
  const MyStaffHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyStaffHomePage> createState() => _MyStaffHomePageState();
}

class _MyStaffHomePageState extends State<MyStaffHomePage> {
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

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    getCurrentUser();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Staff Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => signOut(),
          ),
        ],
      ),
      drawer: MyStaffDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Hello! \n${displayName ?? ""}',
              style: TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 150,
                    color: Color.fromARGB(255, 211, 214, 227),
                    child: const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.person),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                color: Color.fromARGB(255, 201, 203, 187),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 55,
                      child: IconButton(
                        icon: const Icon(Icons.pending_actions),
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatusStaffPage()),
                          );
                        },
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 150,
                    color: Color.fromARGB(255, 232, 208, 180),
                    child: const Center(
                      child: Text(
                        'Report',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.report),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewReport()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                color: Color.fromARGB(255, 71, 18, 42),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 55,
                      child: IconButton(
                        icon: const Icon(Icons.article),
                        color: Color.fromARGB(255, 201, 203, 187),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsStaffPage()),
                          );
                        },
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'News',
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 203, 187),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
