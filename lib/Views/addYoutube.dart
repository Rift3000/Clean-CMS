import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clean_cms/Views/addArticle.dart';
import 'package:clean_cms/edit/youtube_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddYoutubeScreen extends StatefulWidget {
  AddYoutubeScreen({Key key}) : super(key: key);

  @override
  _AddYoutubeScreenState createState() => _AddYoutubeScreenState();
}

class _AddYoutubeScreenState extends State<AddYoutubeScreen> {
  Color secondaryColor = Color(0xff232c51);
  Color primaryColor = Color(0xff18203d);
  Color thirdColor = Color(0xff58439A);
  Color logoGreen = Color(0xff2AB96B);

  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();
  TextEditingController desController = TextEditingController();

  Map<String, dynamic> videoToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Youtube");

  Widget _child;

  @override
  void initState() {
    super.initState();
    _child = AddYoutubeScreen();
  }

  addVideo() {
    videoToAdd = {
      "title": titleController.text,
      "description": desController.text,
      "url": urlController.text,
      "imgUrl": imgUrlController.text,
    };

    collectionReference
        .add(videoToAdd)
        .whenComplete(() => print('Added Video to list'));
  }

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none),
      ),
    );
  }

  void showDialog(
      BuildContext context, String title, String desc, DialogType log) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: log,
      title: title,
      desc: desc,
      headerAnimationLoop: false,
      autoHide: Duration(milliseconds: 7000),
      showCloseIcon: true,
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => EditYoutube()));
            },
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Youtube Video CMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            _buildTextField(titleController, "Title"),
            SizedBox(
              height: 30.0,
            ),
            _buildTextField(desController, "Description"),
            SizedBox(
              height: 30.0,
            ),
            _buildTextField(urlController, "Url"),
            SizedBox(
              height: 30.0,
            ),
            _buildTextField(imgUrlController, "imgUrl"),
            SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              padding: EdgeInsets.all(20),
              onPressed: () {
                if (imgUrlController.text.length <= 1 &&
                    desController.text.length <= 1 &&
                    titleController.text.length <= 1 &&
                    urlController.text.length <= 1) {
                  showDialog(context, "Failed!", "Please enter all the fields",
                      DialogType.ERROR);
                } else {
                  addVideo();
                  imgUrlController.text = "";
                  desController.text = "";
                  titleController.text = "";
                  urlController.text = "";
                  showDialog(context, "Success!",
                      "Your Youtube Video was added.", DialogType.SUCCES);
                }
              },
              color: logoGreen,
              child: Text(
                'Add Youtube Video',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
