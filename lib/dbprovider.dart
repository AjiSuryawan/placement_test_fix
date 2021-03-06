
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import './memo_model.dart'; //import model class
import 'dart:io';
import 'dart:async';

class MemoDbProvider{
    
Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path,"Movie.db"); //create path to database

      return await openDatabase( //open the database or create a database if there isn't any
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE Movie(
          id TEXT,
          title TEXT,
          content TEXT,
          image TEXT)"""
      );
    });
  }

  Future<int> addItem(MovieModel item) async{ //returns number of items inserted as an integer
    final db = await init(); //open database
    return db.insert("Movie", item.toMap(), //toMap() function from MemoModel
    conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
 }

 Future<List<MovieModel>> fetchMemos() async{ //returns the memos as a list (array)
    
    final db = await init();
    final maps = await db.query("Movie"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) { //create a list of memos
      return MovieModel(
        maps[i]['id'].toString(),
        maps[i]['title'].toString(),
        maps[i]['content'].toString(),
        maps[i]['image'].toString(),
      );
  });
  }

  Future<int> deleteMemo(int id) async{ //returns number of items deleted
    final db = await init();
  
    int result = await db.delete(
      "Movie", //table name
      where: "id = ?",
      whereArgs: [id] // use whereArgs to avoid SQL injection
    );

    return result;
  }

  
Future<int> updateMemo(int id, MovieModel item) async{ // returns the number of rows updated
  
    final db = await init();
  
    int result = await db.update(
      "Movie",
      item.toMap(),
      where: "id = ?",
      whereArgs: [id]
      );
      return result;
 }
    
}