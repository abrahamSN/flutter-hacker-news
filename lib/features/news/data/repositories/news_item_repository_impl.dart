import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

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
  Future<Either<Failure, List<int>>> getListNews() {
    // TODO: implement getListNews
    return null;
  }

  @override
  Future<Either<Failure, NewsItem>> getNewsItem(int id) {
    // TODO: implement getNewsItem
    return null;
  }
}
