import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/features/quotes/domain/use_cases/delete_quote_use_case.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late MockQuoteRepository mockRepository;
  late DeleteQuotesUseCase useCase;

  setUp(() {
    mockRepository = MockQuoteRepository();
    useCase = DeleteQuotesUseCase(mockRepository);
  });

  test('', () async {
    // arrange
    const deletingQuote =
        Quote(id: '1', author: 'John Cena', content: 'A quote');
    when(() => mockRepository.deleteQuote(deletingQuote))
        .thenAnswer((_) async => const Right(deletingQuote));
    // act
    final result = await useCase.call(deletingQuote);
    // assert
    verify(() => mockRepository.deleteQuote(deletingQuote));
    expect(result, const Right(deletingQuote));
  });
}
