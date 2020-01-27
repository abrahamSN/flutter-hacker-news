import 'package:dartz/dartz.dart';
import 'package:news/core/errors/failure.dart';
import 'package:news/core/usecases/usecase.dart';

import '../repositories/news_item_repository.dart';

class GetListNews implements UseCase<List<int>, NoParams> {
  final NewsItemRepository repository;

  GetListNews(this.repository);

  Future<Either<Failure, List<int>>> call(NoParams params) async {
    return await repository.getListNews();
  }
}