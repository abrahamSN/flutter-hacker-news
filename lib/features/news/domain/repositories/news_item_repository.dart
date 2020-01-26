import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

import '../entities/news_item.dart';

abstract class NewsItemRepository {
  Future<Either<Failure, List<int>>> getListNews();
  Future<Either<Failure, NewsItem>> getNewsItem(int id);
}