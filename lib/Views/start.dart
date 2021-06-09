import 'package:clean_cms/Views/login.dart';
import 'package:flutter/material.dart';

class Started extends StatefulWidget {
  Started({Key key}) : super(key: key);

  @override
  _StartedState createState() => _StartedState();
}

class _StartedState extends State<Started> {
  final logoGreen = Color(0xff2AB96B);
  final Color primaryColor = Color(0xff18203d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //We take the image from the assets
          Image.asset(
            'image/outer_space.png',
            height: 250,
          ),
          SizedBox(
            height: 20,
          ),
          //Texts and Styling of them
          Text(
            'Welcome to Clean CMS',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Managing your mobile store in a simple and easy manner!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            elevation: 0,
            height: 50,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            color: logoGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
