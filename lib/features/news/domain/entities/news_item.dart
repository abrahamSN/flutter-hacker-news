import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewsItem extends Equatable {
  final String by;
  final int descendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  NewsItem({
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

  @override
  // TODO: implement props
  List<Object> get props => [by, descendants, id, kids, score, time, title, type, url];
}
