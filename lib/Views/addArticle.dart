import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clean_cms/edit/article_edit.dart';
import 'package:clean_cms/edit/youtube_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AddArticleScreen extends StatefulWidget {
  AddArticleScreen({Key key}) : super(key: key);

  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  Color secondaryColor = Color(0xff232c51);
  Color primaryColor = Color(0xff18203d);
  Color logoGreen = Color(0xff2AB96B);

  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();

  Map<String, dynamic> articleToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Articles");

  addArticle() {
    articleToAdd = {
      "title": titleController.text,
      "url": urlController.text,
      "image": imgUrlController.text,
    };

    collectionReference
        .add(articleToAdd)
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

  showDialog(BuildContext context, String title, String desc, DialogType log) {
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
                  context, MaterialPageRoute(builder: (_) => EditArticle()));
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
              'Article CMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40.0,
            ),
            _buildTextField(titleController, "Title"),
            SizedBox(
              height: 30.0,
            ),
            _buildTextField(urlController, "Url"),
            SizedBox(
              height: 30.0,
            ),
            _buildTextField(imgUrlController, "Image"),
            SizedBox(
              height: 60.0,
            ),
            MaterialButton(
              padding: EdgeInsets.all(20),
              onPressed: () {
                if (imgUrlController.text.length <= 1 &&
                    titleController.text.length <= 1 &&
                    urlController.text.length <= 1) {
                  showDialog(context, "Failure!", "The Article was not added",
                      DialogType.ERROR);
                } else {
                  addArticle();
                  imgUrlController.text = "";
                  titleController.text = "";
                  urlController.text = "";

                  showDialog(context, "Success!", "Your Article was added.",
                      DialogType.SUCCES);
                }
              },
              color: logoGreen,
              child: Text(
                'Add Article',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
