import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dbprovider.dart';
import 'memo_model.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  ImagePicker picker = ImagePicker();
  XFile? _image;
  var _imageKu;
  MemoDbProvider memoDb = MemoDbProvider();
  TextEditingController ctrjudul = new TextEditingController();
  TextEditingController ctrdesc = new TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, 'update');
        Navigator.pop(context, 'update');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Information"),
      content: Text("File saved successfully "),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Movie"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  _image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _imageKu = File(_image!.path.toString());
                    print("gambarku : " + _imageKu.toString());
                  });
                },
                child: _imageKu != null
                    ? Image.file(
                        File(_imageKu!.path.toString()),
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Form(
                child: Builder(
                  builder: (context) => ListView(
                    padding: EdgeInsets.all(20),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Tambah Movie",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 28.0),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: Colors.black, width: 0.5)),
                            child: TextFormField(
                                controller: ctrjudul,
                                cursorColor: Colors.black,
                                autofocus: false,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 15, bottom: 5),
                                  isDense: true,
                                  hintText: "judul",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  border: InputBorder.none,
                                ))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: Colors.black, width: 0.5)),
                            child: TextFormField(
                                controller: ctrdesc,
                                cursorColor: Colors.black,
                                autofocus: false,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 15, bottom: 5),
                                  isDense: true,
                                  hintText: "desc",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  border: InputBorder.none,
                                ))),
                      ),

                      SizedBox(
                        height: 16.0,
                      ),
                      // submit button
                      InkWell(
                        onTap: () async {
                          DateTime now = DateTime.now();

                          final memo = MovieModel(
                              now.year.toString() +
                                  "" +
                                  now.month.toString() +
                                  "" +
                                  now.day.toString() +
                                  "" +
                                  now.hour.toString() +
                                  "" +
                                  now.minute.toString() +
                                  "" +
                                  now.second.toString(),
                              ctrjudul.text.toString(),
                              ctrdesc.text.toString(),
                              _image!.path.toString());
                          await memoDb.addItem(memo);
                          showAlertDialog(context);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              //change color here
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
