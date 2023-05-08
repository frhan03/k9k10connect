import 'package:flutter/material.dart';
import 'package:k9k10connect/pages/report.dart';
import 'package:k9k10connect/pages/status.dart';
import 'package:k9k10connect/homepage.dart';
import 'pages/profile.dart';
import 'pages/newspage.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.grey,),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Homepage()),
              );
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
    );
  }

}