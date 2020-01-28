import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news/core/platforms/network_info.dart';

import 'package:news/features/news/data/datasources/news_item_local_data_source.dart';
import 'package:news/features/news/data/datasources/news_item_remote_data_source.dart';
import 'package:news/features/news/data/repositories/news_item_repository_impl.dart';

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
}
