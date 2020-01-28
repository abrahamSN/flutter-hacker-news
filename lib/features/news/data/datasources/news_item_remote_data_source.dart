import 'package:news/features/news/data/models/news_item_model.dart';

abstract class NewsItemRemoteDataSource {
  Future<List<int>> getListNews();

  Future<NewsItemModel> getNewsItem(int id);
}
