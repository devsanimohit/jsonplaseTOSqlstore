import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:http/http.dart'as http;
import 'package:maptast240223/jsonplaseholder/jsonplaseholdermodel.dart';
import 'package:sqflite/sqflite.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndStorePhotos();
  }

  Future<void> fetchAndStorePhotos() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    final List<Photo> photos = jsonList.map((json) => Photo.fromJson(json)).toList();

    // Open the SQLite database
    final Database database = await openDatabase(
      'photos.db', // Replace with your desired database name
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE photos(
            id INTEGER PRIMARY KEY,
            albumId INTEGER,
            title TEXT,
            url TEXT,
            thumbnailUrl TEXT
          )
        ''');
      },
    );

    // Insert photos into the database
    final batch = database.batch();
    photos.forEach((photo) {
      batch.insert('photos', photo.toJson());
    });
    await batch.commit();
  } else {
    throw Exception('Failed to fetch photos');
  }
}

Future<List<Photo>> fetchPhotosFromSQLite() async {
  // Open the SQLite database
  final Database database = await openDatabase(
    'photos.db', // Replace with your actual database name
    version: 1,
  );

  // Fetch photos from the database
  final List<Map<String, dynamic>> maps = await database.query('photos');

  // Map the retrieved data to List<Photo> objects
  return List.generate(maps.length, (i) {
    return Photo(
      id: maps[i]['id'],
      albumId: maps[i]['albumId'],
      title: maps[i]['title'],
      url: maps[i]['url'],
      thumbnailUrl: maps[i]['thumbnailUrl'],
    );
  });
}


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("Welcome to flutter app")),

            FutureBuilder<List<Photo>>(
          future: fetchPhotosFromSQLite(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${snapshot.data![index].title}'),
                    subtitle: Text('${snapshot.data![index].url}'),
                    leading: Image.network('${snapshot.data![index].thumbnailUrl}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      

        ],
      ),

    );
  }
}