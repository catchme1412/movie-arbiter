import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/album.dart';
import 'widgets/details.dart';
import 'widgets/gridcell.dart';
import 'widgets/movie_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<int> streamController = new StreamController<int>();

  gridview(AsyncSnapshot<List<Album>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        color: Colors.blueGrey[900],
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: snapshot.data.map(
            (album) {
              return GestureDetector(
                child: GridTile(
                  child: AlbumCell(album),
                ),
                onTap: () {
                  goToDetailsPage(context, album);
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  goToDetailsPage(BuildContext context, Album album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => MyHomePage(
          album,
        ),
      ),
    );
  }

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: StreamBuilder(
            initialData: 0,
            stream: streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Text('Movie Arbiter');
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.search,
//              color: Colors.white,
//            ),
//            title: Text('Search'),
//          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dehaze,
              color: Colors.white,
            ),
            title: Text(
              'Filter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: FutureBuilder<List<Album>>(
              future: Services.getLatest(),
              builder: (context, snapshot) {
                // not setstate here
                //
                if (snapshot.hasError) {
                  print("Error ${snapshot.error}");
                  return Center(
                      child: Text('Please check your internet connection'));
                }
                //
                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  // gridview
                  return gridview(snapshot);
                }

                return circularProgress();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
