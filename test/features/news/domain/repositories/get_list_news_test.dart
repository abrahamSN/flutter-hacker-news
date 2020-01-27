import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/core/usecases/usecase.dart';
import 'package:news/features/news/domain/entities/news_item.dart';

import 'package:news/features/news/domain/repositories/news_item_repository.dart';
import 'package:news/features/news/domain/usecases/get_list_news.dart';

class MockListNewsRepository extends Mock implements NewsItemRepository {}

void main() {
  GetListNews usecase;
  MockListNewsRepository mockListNewsRepository;

  setUp(() {
    mockListNewsRepository = MockListNewsRepository();
    usecase = GetListNews(mockListNewsRepository);
  });

  final tIdNews = 22148293;
  final List<int> tListNews = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  test(
    'should get list news from repository',
    () async {
      // arrange
      when(mockListNewsRepository.getListNews())
          .thenAnswer((_) async => Right(tListNews));

      // act
      final res = await usecase(NoParams());

      // assert
      expect(res, Right(tListNews));
      verify(mockListNewsRepository.getListNews());
      verifyNoMoreInteractions(mockListNewsRepository);
    },
  );
}
