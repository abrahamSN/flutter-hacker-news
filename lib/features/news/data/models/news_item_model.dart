import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:news/features/news/domain/entities/news_item.dart';

class NewsItemModel extends NewsItem {
  final String by;
  final int descendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  NewsItemModel({
    @required this.by,
    @required this.descendants,
    @required this.id,
    @required this.kids,
    @required this.score,
    @required this.time,
    @required this.title,
    @required this.type,
    @required this.url,
  });

  factory NewsItemModel.fromJson(Map<String, dynamic> parsedJson) {
    return NewsItemModel(
      by: parsedJson['by'],
      descendants: parsedJson['descendants'],
      id: parsedJson['id'],
      kids: parsedJson['kids'].cast<int>(),
      score: parsedJson['score'],
      time: parsedJson['time'],
      title: parsedJson['title'],
      type: parsedJson['type'],
      url: parsedJson['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'by': by,
      'time': time,
      'kids': kids,
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants,
    };
  }
}
