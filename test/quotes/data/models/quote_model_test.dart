import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/features/quotes/data/models/quote_model.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tQuoteModel = QuoteModel(
    id: "12LONGID",
    author: 'William James',
    content:
        "Most people never run far enough on their first wind to find out they've got a second.",
  );

  test('should NumberTriviaModel be a subtype of NumberTrivia Entity', () {
    expect(tQuoteModel, isA<Quote>());
  });

  group('fromJson', () {
    test(
      'should return a valid model for a valid JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('quote.json'));
        // act
        final result = QuoteModel.fromJson(jsonMap);
        // assert
        expect(result, tQuoteModel);
      },
    );
  });
}
