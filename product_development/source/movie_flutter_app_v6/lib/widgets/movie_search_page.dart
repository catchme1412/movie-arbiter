import 'package:flutter/material.dart';

import '../context/movie_app_context.dart';
import '../models/album.dart';
import '../widgets/movie_card.dart';
import '../widgets/page_footer.dart';

class SearchList extends StatefulWidget {
  static const ROUTE = "search-list";
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text(
    "",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<Album> _list = List();
  List<Album> _searchList = List();

  bool _IsSearching;
  String _searchText = "";
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();
  }

  Future<void> init() async {
    List<Album> movies =
        await MovieAppContext().getMovieService().getLatestMovies();
    setState(() {
      _list.addAll(movies);
    });

    _searchList = _list;
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        key: key,
        appBar: buildBar(context),
        bottomNavigationBar: PageFooterBar(),
        body: GridView.builder(
          padding: EdgeInsets.all(0),
          itemCount: _searchList.length,
          itemBuilder: (context, index) {
            debugPrint(">>>>>>>>>>>>>>>>>>" + (_searchList.length.toString()));
            return MovieCard(
              album: _searchList[index],
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
          ),
        ),
      ),
    );
  }

  List<Album> _buildList() {
    return _list; //_list.map((contact) =>  Uiitem(contact)).toList();
  }

  List<Album> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList =
          _list; //_list.map((contact) =>  Uiitem(contact)).toList();
    } else {
      _searchList = _list
          .where((element) =>
              element.title.toLowerCase().contains(_searchText.toLowerCase()) ||
              element.genre
                  .toString()
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList;
    }
  }

  Widget buildBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
          flexibleSpace: Column(
//            children: <Widget>[Text('ff'), Text("FF")],
              ),
          elevation: 0,
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: appBarTitle,
          iconTheme: IconThemeData(color: Colors.black87),
          actions: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black87,
              child: IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = Icon(
                        Icons.close,
                        color: Colors.white,
                      );
                      this.appBarTitle = TextField(
                        controller: _searchQuery,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                            hintText: "Search here..",
                            hintStyle: TextStyle(color: Colors.grey)),
                      );
                      _handleSearchStart();
                    } else {
                      _handleSearchEnd();
                    }
                  });
                },
              ),
            ),
          ]),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: DARK_THEME,
//      home: SearchList(),
//    );
//  }
//}
