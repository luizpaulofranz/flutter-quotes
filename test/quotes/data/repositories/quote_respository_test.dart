import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/core/local_cache/local_cache_service.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

import '../../../fixtures/fixture_reader.dart';

class MockQuoteDataSource extends Mock implements QuoteDataSource {}

class MockLocalCacheService extends Mock implements LocalCacheService {}

void main() {
  late MockQuoteDataSource mockDataSource;
  late MockLocalCacheService mockLocalCache;
  late QuoteRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockQuoteDataSource();
    mockLocalCache = MockLocalCacheService();
    repository = QuoteRepositoryImpl(mockDataSource, mockLocalCache);
  });

  group('getQuotes tests', () {
    test('should return remote data when the call to data source is successful',
        () async {
      // arrange
      final expected = getQuotesList();
      when(() => mockLocalCache.getCacheData(key: any(named: 'key')))
          .thenAnswer((_) => null);
      when(() => mockDataSource.getQuotes()).thenAnswer((_) async => expected);
      // act
      final result = await repository.getQuotes();
      // assert
      verify(() => mockDataSource.getQuotes());
      verify(() => mockLocalCache.getCacheData(key: quotesKey));
      verify(
          () => mockLocalCache.setCacheData(key: quotesKey, value: expected));
      expect(result.getOrElse(() => []), equals(expected));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockDataSource.getQuotes()).thenThrow(const ApiException());
      // act
      final result = await repository.getQuotes();
      // assert
      verify(() => mockDataSource.getQuotes());
      expect(result, equals(const Left(Failure())));
    });
  });

  group('deleteQuotes tests', () {
    test('should return the deleted Quote from localCache instance', () async {
      // arrange
      final quotesList = getQuotesList();
      const expected = Quote(
        id: 'ch-0pti9X6U',
        author: 'Joe Adcock',
        content:
            'Trying to sneak a fastball past Hank Aaron is like trying to sneak the sunrise past a rooster.',
      );
      when(() =>
              mockLocalCache.getCacheData<List<Quote>>(key: any(named: 'key')))
          .thenAnswer((_) => quotesList);
      // act
      final result = await repository.deleteQuote(expected);
      // assert
      verify(() => mockLocalCache.getCacheData<List<Quote>>(key: quotesKey));
      verify(() => mockLocalCache.clearCache());
      quotesList.remove(expected);
      verify(
        () => mockLocalCache.setCacheData(key: quotesKey, value: quotesList),
      );
      expect(result, equals(const Right(expected)));
    });
  });

  group('updateQuote tests', () {
    test('should return the updated Quote from localCache instance', () async {
      // arrange
      final quotesList = getQuotesList();
      const expected = Quote(
        id: 'ch-0pti9X6U',
        author: 'Jonh Cena',
        content: 'A new quote',
      );
      when(() =>
              mockLocalCache.getCacheData<List<Quote>>(key: any(named: 'key')))
          .thenAnswer((_) => quotesList);
      // act
      final result = await repository.updateQuote(expected);
      // assert
      verify(() => mockLocalCache.getCacheData<List<Quote>>(key: quotesKey));
      verify(() => mockLocalCache.clearCache());
      quotesList.replaceRange(1, 1 + 1, [expected]);
      verify(
        () => mockLocalCache.setCacheData(key: quotesKey, value: quotesList),
      );
      expect(result, equals(const Right(expected)));
    });
  });
}
