import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:news/core/errors/failure.dart';
import 'package:news/features/news/domain/entities/news_item.dart';

import '../repositories/news_item_repository.dart';

class GetNewsItem {
  final NewsItemRepository repository;

  GetNewsItem(this.repository);

  Future<Either<Failure, NewsItem>> execute({@required int id}) async {
    return await repository.getNewsItem(id);
  }

}