import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';
import 'package:k9k10connect/screens/signin_screen.dart';
import 'package:k9k10connect/pages/report.dart';
import 'package:k9k10connect/pages/newspage.dart';
import 'package:k9k10connect/pages/profile.dart';
import 'package:k9k10connect/pages/status.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: Color(0xff6750a4), useMaterial3: true
          // primarySwatch: Colors.blue,
          ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut().then((value) {
              print("Signed out");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            }),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Hello! \nNur Amirah',
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
                          // color: Colors.white,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.person),
                      iconSize: 30,
                      // color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()),
                        );
// handle menu button press
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                // color: Colors.green,
                color: Color.fromARGB(255, 201, 203, 187),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 55,
                      child: IconButton(
                        icon: const Icon(Icons.pending_actions),
                        // color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StatusPage()),
                          );
// handle menu button press
                        },
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 20,
                            //color: Colors.white,
                           // fontWeight: FontWeight.bold,
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
                    // color: Colors.lightBlue,
                    color: Color.fromARGB(255, 232, 208, 180),
                    child: const Center(
                      child: Text(
                        'Report',
                        style: TextStyle(
                          //color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.report),
                      // color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const report()),
                        );
// handle menu button press
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                // color: Colors.grey,
                color: Color.fromARGB(255, 71, 18, 42),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 55,
                      child: IconButton(
                        icon: const Icon(Icons.article),
                        color: Color.fromARGB(255, 201, 203, 187),

                        // color: Colors.white,

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewsPage()),
                          );
// handle menu button press
                        },
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'News',
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 203, 187),
                            // fontWeight: FontWeight.bold,
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
