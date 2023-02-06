import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/data/models/quote_model.dart';
import 'package:quotes/features/quotes/data/repositories/quote_repository_impl.dart';

import '../../../fixtures/fixture_reader.dart';

class MockQuoteDataSource extends Mock implements QuoteDataSource {}

void main() {
  late MockQuoteDataSource mockDataSource;
  late QuoteRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockQuoteDataSource();
    repository = QuoteRepositoryImpl(mockDataSource);
  });

  group('getQuotes tests', () {
    test('should return remote data when the call to data source is successful',
        () async {
      // arrange
      final jsonData = jsonDecode(fixture('quotes.json'));
      final expected = (jsonData["results"] as List)
          .map((q) => QuoteModel.fromJson(q))
          .toList();
      when(() => mockDataSource.getQuotes()).thenAnswer((_) async => expected);
      // act
      final result = await repository.getQuotes();
      // assert
      verify(() => mockDataSource.getQuotes());
      expect(result, equals(Right(expected)));
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
