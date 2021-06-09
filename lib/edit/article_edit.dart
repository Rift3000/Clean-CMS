import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditArticle extends StatefulWidget {
  EditArticle({Key key}) : super(key: key);

  @override
  _EditArticleState createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  Color secondaryColor = Color(0xff232c51);
  Color primaryColor = Color(0xff18203d);
  Color logoGreen = Color(0xff2AB96B);

  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('Articles');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data.docs[index];
                  return ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () {
                          imgController.text = doc['image'];
                          titleController.text = doc['title'];
                          urlController.text = doc['url'];

                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Container(
                                      color: primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            _buildTextField(
                                                titleController, "Title"),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            _buildTextField(
                                                urlController, "Url"),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            _buildTextField(
                                                imgController, "Image"),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            MaterialButton(
                                              padding: EdgeInsets.all(20),
                                              onPressed: () {
                                                snapshot
                                                    .data.docs[index].reference
                                                    .update({
                                                  "title": titleController.text,
                                                  "url": urlController.text,
                                                  "image": imgController.text,
                                                });
                                                Navigator.pop(context);
                                              },
                                              color: logoGreen,
                                              child: Text(
                                                'Update Articles',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            MaterialButton(
                                              padding: EdgeInsets.all(20),
                                              onPressed: () {
                                                snapshot
                                                    .data.docs[index].reference
                                                    .delete();

                                                Navigator.pop(context);
                                              },
                                              color: Colors.red,
                                              child: Text(
                                                'Delete Article',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                      ),
                      title: Text(
                        doc['title'],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Image.network(
                        doc['image'],
                        height: 120,
                        width: 100,
                        fit: BoxFit.cover,
                      ));
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
