import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/news/data/models/news_item_model.dart';

import 'package:news/features/news/domain/entities/news_item.dart';

import '../../../../assets/asset_reader.dart';

void main() {
  final tNewsItemModel = NewsItemModel(
      by: "massung",
      descendants: 23,
      id: 22148293,
      kids: [
        22148391,
        22148835,
        22150421,
        22148789,
        22148884,
        22150380,
        22150608,
        22148649,
        22151258,
        22148466,
        22148630
      ],
      score: 205,
      time: 1579982312,
      title: "Show HN: R-cade, a simple arcade game engine for Racket",
      type: "story",
      url: "https://github.com/massung/r-cade/");

  test('should be a subclass of NewsItem entity', () async {
    // assert
    expect(tNewsItemModel, isA<NewsItem>());
  });

  test('should return from json map into an object', () async {
    // arrange
    final Map<String, dynamic> parsedJson =
        json.decode(asset('news_item.json'));

    // act
    final res = NewsItemModel.fromJson(parsedJson);

    // assert
    expect(res, tNewsItemModel);
  });

  test('should return a JSON map containing the proper data', () async {
    // act
    final res = tNewsItemModel.toMap();

    // assert
    final expectedMap = {
      "by": "massung",
      "descendants": 23,
      "id": 22148293,
      "kids": [
        22148391,
        22148835,
        22150421,
        22148789,
        22148884,
        22150380,
        22150608,
        22148649,
        22151258,
        22148466,
        22148630
      ],
      "score": 205,
      "time": 1579982312,
      "title": "Show HN: R-cade, a simple arcade game engine for Racket",
      "type": "story",
      "url": "https://github.com/massung/r-cade/"
    };

    expect(res, expectedMap);
  });
}
