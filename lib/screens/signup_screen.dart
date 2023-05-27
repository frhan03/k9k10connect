import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../homepage.dart';
import '../reusable/reusable_widgets.dart';
import '../utils/colors_utils.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // TextEditingController _userNameTextController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNoController = TextEditingController();

  bool passwordConfirmed(){
    if (_passwordTextController.text.trim() == 
        _confirmPasswordController.text.trim()){
          return true;
    } else{
      return false;
    }
  }

  Future addUserDetails (String firstName, String lastName, String phoneNo, String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'phone no.': phoneNo,
      'email': email,
    });  
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    ),body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
            // hexStringToColor("CB2B93"),
            // hexStringToColor("9546C4"),
            // hexStringToColor("5E61F4")
            hexStringToColor("D2D7DF"),
            hexStringToColor("BDBBB0"),
            hexStringToColor("D8BFAA")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // reusableTextField("Enter UserName", Icons.person_outline, false,
                  //     _userNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("First Name", Icons.person_outline, false,
                      _firstNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Last Name", Icons.person_outline, false,
                      _lastNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Phone No.", Icons.phone_outlined, false,
                      _phoneNoController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Email Address", Icons.mail_outlined, false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Password", Icons.lock_outlined, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Confirm Password", Icons.lock_outlined, true,
                      _confirmPasswordController),
                  const SizedBox(
                    height: 20,
                  ),
                signInSignUpButton
                  (context,
                    false, (){
                      // authenticate user
                      if (passwordConfirmed()){
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController.text.trim(), 
                          password: _passwordTextController.text.trim(),
                        ).then((value) {
                          Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Homepage()));
                        }).onError((error, stackTrace){
                          print("Error ${error.toString()}");
                        });

                        // add user details
                        addUserDetails(
                          _firstNameController.text.trim(), 
                          _lastNameController.text.trim(), 
                          _phoneNoController.text.trim(),
                          _emailTextController.text.trim(),
                        );
                      }
                  })
                ],
              ),
            ))),
    );
  }
}
