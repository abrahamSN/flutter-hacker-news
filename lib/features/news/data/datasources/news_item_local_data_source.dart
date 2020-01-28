import 'package:news/features/news/data/models/news_item_model.dart';

abstract class NewsItemLocalDataSource {
  Future<NewsItemModel> getNewsItem(int id);
}
