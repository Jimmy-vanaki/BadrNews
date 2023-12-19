import 'dart:convert';
import 'package:badrnews/api/news_model.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<PostNews>? fetchNews(int gid) async {
  final response = await http.get(
    Uri.https('bnnews.iq', '/api/news', {'gid': gid.toString()}),
  );
  if (response.statusCode == 200) {
    // List<PostNews> listPost = List<PostNews>.from(
    //     jsonDecode(response.body).map((x) => PostNews.fromJson(x)));
    // return listPost;
    Constants.changeCategory = true;
    return PostNews.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Faild to load Posts');
  }
}

Future<PostNewsContent>? fetchNewsContent(int newsTag) async {
  final response = await http.post(
    Uri.https('bnnews.iq', '/api/news/content', {'id': newsTag.toString()}),
  );
  if (response.statusCode == 200) {
    return PostNewsContent.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Faild to load Posts');
  }
}

Future<Search>? fetchSearchItem(
  String searchWord,
  String searchInTitle,
  String searchInText,
) async {
  debugPrint(searchWord+searchInText+searchInTitle);

  final response = await http.get(
    Uri.https('bnnews.iq', '/api/news', {
      'sw': searchWord,
      'sctxt': searchInText,
      'sctitle': searchInTitle,
    }),
  );
  debugPrint(response.statusCode.toString());
  if (response.statusCode == 200) {
    return Search.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Faild to load Posts');
  }
}
