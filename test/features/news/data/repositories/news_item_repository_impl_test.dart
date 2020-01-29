import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news/core/errors/exception.dart';
import 'package:news/core/errors/failure.dart';

import 'package:news/core/platforms/network_info.dart';

import 'package:news/features/news/data/datasources/news_item_local_data_source.dart';
import 'package:news/features/news/data/datasources/news_item_remote_data_source.dart';

import 'package:news/features/news/data/models/news_item_model.dart';

import 'package:news/features/news/data/repositories/news_item_repository_impl.dart';
import 'package:news/features/news/domain/entities/news_item.dart';

class MockRemoteDataSource extends Mock implements NewsItemRemoteDataSource {}

class MockLocalDataSource extends Mock implements NewsItemLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NewsItemRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repositoryImpl = NewsItemRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tIdNews = 22148293;
  final List<int> tListNews = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
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
  final NewsItem tNewsItem = tNewsItemModel;

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('get list news item', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      repositoryImpl.getListNews();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      group('List data', () {
        test('should return list data when call remote data is successfull',
            () async {
          // arrage
          when(mockRemoteDataSource.getListNews())
              .thenAnswer((_) async => tListNews);

          // act
          final res = await repositoryImpl.getListNews();

          // assert
          verify(mockRemoteDataSource.getListNews());
          expect(res, equals(Right(tListNews)));
        });

        test(
            'should return server failure when call list remote data is unsuccessfull',
            () async {
          // arrage
          when(mockRemoteDataSource.getListNews()).thenThrow(ServerException());

          // act
          final res = await repositoryImpl.getListNews();

          // assert
          verify(mockRemoteDataSource.getListNews());
          verifyZeroInteractions(mockLocalDataSource);
          expect(res, equals(Left(ServerFailure())));
        });
      });

      group('Item data', () {
        test('should return data when call remote data is successfull',
            () async {
          // arrage
          when(mockRemoteDataSource.getNewsItem(any))
              .thenAnswer((_) async => tNewsItemModel);

          // act
          final res = await repositoryImpl.getNewsItem(tIdNews);

          // assert
          verify(mockRemoteDataSource.getNewsItem(tIdNews));
          expect(res, equals(Right(tNewsItemModel)));
        });

        test(
            'should save the data locally when the call remote data is successfull',
            () async {
          // arrage
          when(mockRemoteDataSource.getNewsItem(any))
              .thenAnswer((_) async => tNewsItemModel);

          // act
          await repositoryImpl.getNewsItem(tIdNews);

          // assert
          verify(mockRemoteDataSource.getNewsItem(tIdNews));
          verify(mockLocalDataSource.postNewsItem(tNewsItemModel));
        });

        test(
            'should return server failure when call remote data is unsuccessfull',
            () async {
          // arrage
          when(mockRemoteDataSource.getNewsItem(any))
              .thenThrow(ServerException());

          // act
          final res = await repositoryImpl.getNewsItem(tIdNews);

          // assert
          verify(mockRemoteDataSource.getNewsItem(tIdNews));
          verifyZeroInteractions(mockLocalDataSource);
          expect(res, equals(Left(ServerFailure())));
        });
      });
    });

    runTestOffline(() {
      group('Item data', () {
        test(
            'should load local data when the call to local data is successfull',
            () async {
          // arrage
          when(mockLocalDataSource.getNewsItem(any))
              .thenAnswer((_) async => tNewsItemModel);

          // act
          final res = await repositoryImpl.getNewsItem(tIdNews);

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getNewsItem(tIdNews));
          expect(res, equals(Right(tNewsItem)));
        });

        test('should return local failure when there is no local data present',
            () async {
          // arrage
          when(mockLocalDataSource.getNewsItem(any))
              .thenThrow(LocalException());

          // act
          final res = await repositoryImpl.getNewsItem(tIdNews);

          // assert
          verify(mockLocalDataSource.getNewsItem(tIdNews));
          verifyZeroInteractions(mockRemoteDataSource);
          expect(res, equals(Left(LocalFailure())));
        });
      });
    });
  });
}
