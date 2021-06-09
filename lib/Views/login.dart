import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clean_cms/Views/addYoutube.dart';
import 'package:clean_cms/Views/switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showDialog(BuildContext context, String title, String desc) {
      AwesomeDialog(
        context: context,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.SUCCES,
        title: title,
        desc: desc,
        headerAnimationLoop: false,
        autoHide: Duration(milliseconds: 9000),
        showCloseIcon: true,
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      )..show();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in and continue',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email and password below to continue to the app',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextField(
                    nameController, Icons.account_circle, 'Username', false),
                SizedBox(height: 20),
                _buildTextField(
                    passwordController, Icons.lock, 'Password', true),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    try {
                      await Firebase.initializeApp();
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: nameController.text,
                        password: passwordController.text,
                      );

                      if (userCredential != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Switcheroo()));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        nameController.text = "";
                        passwordController.text = "";
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        nameController.text = "";
                        passwordController.text = "";
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  color: logoGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    //Here goes the logic for Google SignIn discussed in the next section
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text('Sign-in using Google',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 100),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: null //_buildFooterLogo(),
                    )
              ],
            ),
          ),
        ));
  }

  /* _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/tgd_white.png',
          height: 40,
        ),
        Text('The Growing Developer',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }*/

  _buildTextField(TextEditingController controller, IconData icon,
      String labelText, bool obscure) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
