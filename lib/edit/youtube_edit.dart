import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditYoutube extends StatefulWidget {
  EditYoutube({Key key}) : super(key: key);

  @override
  _EditYoutubeState createState() => _EditYoutubeState();
}

class _EditYoutubeState extends State<EditYoutube> {
  Color secondaryColor = Color(0xff232c51);
  Color primaryColor = Color(0xff18203d);
  Color logoGreen = Color(0xff2AB96B);

  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('Youtube');

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
                          imgUrlController.text = doc['imgUrl'];
                          desController.text = doc['description'];
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
                                                desController, "Description"),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            _buildTextField(
                                                urlController, "Url"),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            _buildTextField(
                                                imgUrlController, "imgUrl"),
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
                                                  "description":
                                                      desController.text,
                                                  "url": urlController.text,
                                                  "imgUrl":
                                                      imgUrlController.text,
                                                });
                                                Navigator.pop(context);
                                              },
                                              color: logoGreen,
                                              child: Text(
                                                'Update Youtube Video',
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
                                                'Delete Youtube Video',
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
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['url'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      trailing: Image.network(
                        doc['imgUrl'],
                        height: 120,
                        width: 100,
                        fit: BoxFit.cover,
                      ));
                });
          } else {
            return Text("");
          }
        },
      ),
    );
  }
}
