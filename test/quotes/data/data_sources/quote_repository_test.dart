import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source_impl.dart';
import 'package:quotes/features/quotes/data/models/quote_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late QuoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = QuoteDataSourceImpl(client: mockHttpClient);
  });

  group("getQuotes Tests", () {
    test("Should do a GET on quotes API and return a list of quotes.",
        () async {
      // arrange
      final jsonData = jsonDecode(fixture('quotes.json'));
      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(
          path: quotesUrl,
        ),
        data: jsonData,
      );

      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => response,
      );
      // act
      final result = await datasource.getQuotes();
      // assert
      final expected = (jsonData["results"] as List)
          .map((q) => QuoteModel.fromJson(q))
          .toList();
      verify(() => mockHttpClient.get(quotesUrl));
      expect(result, expected);
    });

    test("Should throw a exception when API returns an Error.", () async {
      // arrange
      final exception = DioError(
        requestOptions: RequestOptions(path: ''),
        type: DioErrorType.response,
        error: DioErrorType.response,
        response: Response(
          requestOptions: RequestOptions(
            path: '',
          ),
          statusCode: 400,
          data: {
            "error": {"message": "Error Message"}
          },
        ),
      );

      when(() => mockHttpClient.get(any())).thenThrow(exception);
      // act
      // assert

      expect(datasource.getQuotes, throwsA(isA<ApiException>()));
      verify(() => mockHttpClient.get(quotesUrl));
    });
  });
}
