import 'package:flutter/material.dart';
import 'package:k9k10connect/pages/report.dart';
import 'package:k9k10connect/pages/status.dart';
import 'pages/profile.dart';
import 'pages/newspage.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // colorSchemeSeed: Color(0xff6750a4),
          useMaterial3: true
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
        title: const Text(
            'Homepage',
        ),
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(onPressed: (){


          }, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.brown),
              accountName: Text(
                "Nur Amirah",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "nuramirah123@utm.my",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),

            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.pending_actions,
              ),
              title: const Text('Status'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StatusPage()),
                );

              },
            ),
            ListTile(
              leading: Icon(
                Icons.warning,
              ),
              title: const Text('Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const report()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.article,
              ),
              title: const Text('News'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                );
              },
            ),
            // Expanded(
            //     child: Container(
            //       padding: EdgeInsets.symmetric(vertical: 150.0),
            //     )),
            // Column(
            //   children: <Widget>[
            //     _createFooterItem(
            //         icon: Icons.logout,
            //         text: 'Logout',
            //         onTap: () => Navigator.pushReplacementNamed(context, '/'))
            //   ],
            // ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Hello! Nur Amirah',
              style: TextStyle(
                fontSize: 40,
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
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
// handle menu button press
                      },
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                color: Colors.green,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 65,
                      child: const Icon(
                        Icons.pending_actions,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
// handle menu button press
                        },
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
                    color: Colors.lightBlue,
                    child: const Center(
                      child: Text(
                        'Report',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
// handle menu button press
                      },
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: const Icon(
                      Icons.report,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                color: Colors.grey,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 65,
                      child: const Icon(
                        Icons.article,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'News',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
// handle menu button press
                        },
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
