import 'package:flutter/material.dart';

import 'dbprovider.dart';
import 'memo_model.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  MemoDbProvider memoDb = MemoDbProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("makanan"),
      ),
      body: Center(
        child: Container(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
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
                  'Title 1',
                  'Note 1',
                  ""
                );
                await memoDb.addItem(memo);
              },
              child: Text("save"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                var memos = await memoDb.fetchMemos();
                memos.asMap().forEach((index, value) {

                  var body={
                    "varsatu" : value.title.toString(),
                    "vardua" : value.content.toString()
                  };
                  print(body.toString());
                  //hit api
                });
              },
              child: Text("print"),
            ),
          ],
        )),
      ),
    );
  }
}
