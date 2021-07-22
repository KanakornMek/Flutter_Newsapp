import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/pages/detailpage.dart';
import 'package:news_app/services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  late Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = api_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alt',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
              textAlign: TextAlign.center,
            ),
            Text(
              'Zos',
              style: TextStyle(
                  color: Colors.amber[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, AsyncSnapshot<NewsModel> snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                  child: ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        var article = snapshot.data!.articles![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          urL: article.url,
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                            height: 125,
                            child: Row(
                              children: [
                                Card(
                                    margin: EdgeInsets.all(5),
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          article.urlToImage ??
                                              'http://placehold.jp/150x150.png',
                                          fit: BoxFit.cover,
                                        ))),
                                Flexible(
                                    child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.red[900],
                                        ),
                                        child: Text(
                                          article.source!.name!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                      Text(
                                        article.title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      }),
                  onRefresh: refresh);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future refresh() async {
    setState(() {
      _newsModel = api_Manager().getNews();
    });
  }
}
