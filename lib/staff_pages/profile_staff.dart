import 'package:flutter/material.dart';

class StaffProfilePage extends StatelessWidget {
  const StaffProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Container(
              alignment: Alignment(-1, 1),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 100,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.black),
                    title: Text('Name'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.black),
                    title: Text('Phone'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin, color: Colors.black),
                    title: Text('Address'),
                  ),
                  ListTile(
                    leading: Icon(Icons.mail, color: Colors.black),
                    title: Text('Email'),
                  ),
                  Padding(padding: EdgeInsets.only(top: 80.0)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[300],
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _doNothing() {}

AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('Profile'),
    actions: <Widget>[
      IconButton(onPressed: _doNothing, icon: Icon(Icons.notifications)),
    ],
  );
}