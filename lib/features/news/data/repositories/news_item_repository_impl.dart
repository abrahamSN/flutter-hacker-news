import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/core/errors/exception.dart';

import 'package:news/core/errors/failure.dart';
import 'package:news/core/platforms/network_info.dart';

import 'package:news/features/news/data/datasources/news_item_local_data_source.dart';
import 'package:news/features/news/data/datasources/news_item_remote_data_source.dart';

import 'package:news/features/news/domain/entities/news_item.dart';
import 'package:news/features/news/domain/repositories/news_item_repository.dart';

class NewsItemRepositoryImpl implements NewsItemRepository {
  final NewsItemRemoteDataSource remoteDataSource;
  final NewsItemLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsItemRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<int>>> getListNews() async {
    // TODO: implement getListNews
    networkInfo.isConnected;

    try {
      final remoteData = await remoteDataSource.getListNews();

      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NewsItem>> getNewsItem(int id) async {
    // TODO: implement getNewsItem
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getNewsItem(id);
        localDataSource.postNewsItem(remoteData);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDataSource.getNewsItem(id);

        return Right(localData);
      } on LocalException {
        return Left(LocalFailure());
      }
    }
  }
}
