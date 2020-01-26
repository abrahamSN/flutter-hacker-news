import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/news/domain/entities/news_item.dart';

import 'package:news/features/news/domain/repositories/news_item_repository.dart';
import 'package:news/features/news/domain/usecases/get_news_item.dart';

class MockNewsItemRepository extends Mock implements NewsItemRepository {}

void main() {
  GetNewsItem usecase;
  MockNewsItemRepository mockNewsItemRepository;

  setUp(() {
    mockNewsItemRepository = MockNewsItemRepository();
    usecase = GetNewsItem(mockNewsItemRepository);
  });

  final tIdNews = 22148293;
  final tNewsItem = NewsItem(
      by: "massung",
      descendants: 11,
      id: 22148293,
      kids: [
        22148391,
        22148835,
        22148789,
        22148884,
        22148649,
        22148630,
        22148466
      ],
      score: 152,
      time: 1579982312,
      title: "Show HN: R-cade, a simple arcade game engine for Racket",
      type: "story",
      url: "https://github.com/massung/r-cade/");

  test(
    'should get news item',
    () async {
      // arrange
      when(mockNewsItemRepository.getNewsItem(any))
          .thenAnswer((_) async => Right(tNewsItem));

      // act
      final res = await usecase.execute(id: tIdNews);

      // assert
      expect(res, Right(tNewsItem));
      verify(mockNewsItemRepository.getNewsItem(tIdNews));
      verifyNoMoreInteractions(mockNewsItemRepository);
    },
  );
}
