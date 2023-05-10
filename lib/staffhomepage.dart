import 'package:flutter/material.dart';
import 'package:k9k10connect/staffdrawer.dart';


void main() {
  runApp(const StaffHomepage());
}

class StaffHomepage extends StatelessWidget {
  const StaffHomepage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorSchemeSeed: Color(0xff6750a4),
          useMaterial3: true
        // primarySwatch: Colors.blue,
      ),
      home: const MyStaffHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyStaffHomePage extends StatefulWidget {
  const MyStaffHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyStaffHomePage> createState() => _MyStaffHomePageState();
}

class _MyStaffHomePageState extends State<MyStaffHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        //backgroundColor: Colors.brown,
      ),
      drawer: MyStaffDrawer(),
      // Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const UserAccountsDrawerHeader(
      //         decoration: BoxDecoration(color: Color.fromARGB(255, 211, 214, 227),),
      //         accountName: Text(
      //           "Nur Amirah",
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         accountEmail: Text(
      //           "nuramirah123@utm.my",
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         currentAccountPicture: FlutterLogo(),
      //       ),

      //       ListTile(
      //         leading: Icon(
      //           Icons.home,
      //         ),
      //         title: const Text('Home'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.person,
      //         ),
      //         title: const Text('Profile'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const UserProfilePage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.pending_actions,
      //         ),
      //         title: const Text('Status'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const StatusPage()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.warning,
      //         ),
      //         title: const Text('Report'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const report()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.article,
      //         ),
      //         title: const Text('News'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const NewsPage()),
      //           );
      //         },
      //       ),
      //       // Expanded(
      //       //     child: Container(
      //       //       padding: EdgeInsets.symmetric(vertical: 150.0),
      //       //     )),
      //       // Column(
      //       //   children: <Widget>[
      //       //     _createFooterItem(
      //       //         icon: Icons.logout,
      //       //         text: 'Logout',
      //       //         onTap: () => Navigator.pushReplacementNamed(context, '/'))
      //       //   ],
      //       // ),
      //     ],
      //   ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Hello! \nShila',
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
                          //color: Colors.white,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      // color: Colors.white,
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
                      // color: Colors.white,
                      size: 30,
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
                      right: 65,
                      child: const Icon(
                        Icons.pending_actions,
                        // color: Colors.white,
                        size: 30,
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
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        // color: Colors.white,
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
                    top: 0,
                    right: 0,
                    child: IconButton(
                      // color: Colors.white,
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
                      // color: Colors.white,
                      size: 30,
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
                      right: 65,
                      child: const Icon(
                        Icons.article,
                        color: Color.fromARGB(255, 201, 203, 187),
                        size: 30,
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
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        color: Color.fromARGB(255, 201, 203, 187),
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
