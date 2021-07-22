import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/strings.dart';
import 'package:news_app/models/news_model.dart';

class api_Manager {
  Future<NewsModel> getNews() async {
    var client = http.Client();

    var response = await client.get(Uri.parse(Strings.news_url));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      print(jsonString);
      return NewsModel.fromJson(jsonMap);
    } else {
      throw Exception('fail to load');
    }
  }
  Future<NewsModel> updateNews() async {
    var client = http.Client();

    var response = await client.get(Uri.parse(Strings.hello));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      print(jsonString);
      return NewsModel.fromJson(jsonMap);
    } else {
      throw Exception('fail to load');
    }
  }
}
