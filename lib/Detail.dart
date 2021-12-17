import 'dart:io';

import 'package:flutter/material.dart';

import 'memo_model.dart';

class DetailPage extends StatefulWidget {
  final MovieModel model;
  const DetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text("Title : " + widget.model.title.toString()),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.file(
                  File(widget.model.image.toString()),
                ),
              ),
              Text("description : " + widget.model.content.toString()),
            ],
          ),
        )
      ),
    );
  }
}
