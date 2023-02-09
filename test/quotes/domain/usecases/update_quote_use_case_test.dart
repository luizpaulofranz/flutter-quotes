import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/features/quotes/domain/use_cases/update_quote_use_case.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late MockQuoteRepository mockRepository;
  late UpdateQuotesUseCase useCase;

  setUp(() {
    mockRepository = MockQuoteRepository();
    useCase = UpdateQuotesUseCase(mockRepository);
  });

  test('', () async {
    // arrange
    const updatingQuote =
        Quote(id: '1', author: 'John Cena', content: 'A quote');
    when(() => mockRepository.updateQuote(updatingQuote))
        .thenAnswer((_) async => const Right(updatingQuote));
    // act
    final result = await useCase.call(updatingQuote);
    // assert
    verify(() => mockRepository.updateQuote(updatingQuote));
    expect(result, const Right(updatingQuote));
  });
}
