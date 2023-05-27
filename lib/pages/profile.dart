import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k9k10connect/drawer.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('NSXjLY9oxIYKCRDOtsOO') // Replace with the user's document ID
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userData = snapshot.data!.data() as Map<String, dynamic>?;

                if (userData != null) {
                  var firstName = userData['first name'] ?? '';
                  var lastName = userData['last name'] ?? '';
                  var phoneNo = userData['phone no.'] ?? '';
                  var location = userData['location'] ?? '';
                  var email = userData['email'] ?? '';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment(-1, 1),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 170,
                              height: 170,
                              child: GestureDetector(
                                onTap: (){
                                  // Handle profile picture upload
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 80,
                                      backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with the user's profile picture
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 10,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white
                                          ),
                                          color: Color.fromARGB(255, 179, 179, 179),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Name',
                                  hintText: 'Enter Your Name',
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: '$firstName $lastName',
                                ),
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Phone No.',
                                  hintText: 'Enter Your Phone No.',
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: phoneNo,
                                ),
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Location',
                                  hintText: 'Enter Your Location',
                                  icon: Icon(
                                    Icons.location_pin,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: location,
                                ),
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                  hintText: 'Enter Your Email',
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: email,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 50)),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: Text('Back'),
                            //   style: ElevatedButton.styleFrom(
                            //     primary: Colors.grey[300],
                            //     onPrimary: Colors.black,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     padding: EdgeInsets.only(
                            //       left: 30.0,
                            //       right: 30.0,
                            //     ),
                            //   ),
                            // ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle update method
                              },
                              child: Text('Update'),
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
                            ),

                          ],
                        ),
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return Text('Error fetching user data');
              }

              return CircularProgressIndicator();
            },
          ),
        ),
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
