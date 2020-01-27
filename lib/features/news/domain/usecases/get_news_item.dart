import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:news/core/errors/failure.dart';
import 'package:news/core/usecases/usecase.dart';

import 'package:news/features/news/domain/entities/news_item.dart';

import '../repositories/news_item_repository.dart';

class GetNewsItem implements UseCase<NewsItem, Params> {
  final NewsItemRepository repository;

  GetNewsItem(this.repository);

  @override
  Future<Either<Failure, NewsItem>> call(Params params) async {
    return await repository.getNewsItem(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
