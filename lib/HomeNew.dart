import 'dart:io';

import 'package:flutter/material.dart';
import 'package:placement_test/AddMovie.dart';

import 'dbprovider.dart';
import 'memo_model.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({Key? key}) : super(key: key);

  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  List<MovieModel>? list;
  bool loadData = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    MemoDbProvider memoDb = MemoDbProvider();
    var movies = await memoDb.fetchMemos();
    setState(() {
      list = movies;
      print("jumlah data : " + movies.length.toString());
      loadData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placement Test"),
      ),
      body: Center(
        child: loadData == false
            ? ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Image.file(File(list![index].image)),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(list![index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16)),
                                  SizedBox(height: 10),
                                  Text(
                                    '${list![index].content}',
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  ;
                })
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!
          final result = await Navigator.push(
            context,
            // Create the SelectionScreen in the next step.
            MaterialPageRoute(builder: (context) => const AddMovie()),
          );
          if(result.toString() == "update"){
            getData();
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
