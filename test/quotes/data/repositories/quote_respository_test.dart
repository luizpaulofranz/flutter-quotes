import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/core/local_cache/local_cache_service.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/data/models/quote_model.dart';
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
      final jsonData = jsonDecode(fixture('quotes.json'));
      final expected = (jsonData["results"] as List)
          .map((q) => QuoteModel.fromJson(q))
          .map((e) => Quote(id: e.id, author: e.author, content: e.content))
          .toList();
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
}
