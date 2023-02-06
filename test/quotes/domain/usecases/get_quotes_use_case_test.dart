import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/features/quotes/domain/use_cases/get_quotes_use_case.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late MockQuoteRepository mockRepository;
  late GetQuotesUseCase useCase;

  setUp(() {
    mockRepository = MockQuoteRepository();
    useCase = GetQuotesUseCase(mockRepository);
  });

  test('', () async {
    // arrange
    const repoResponse = [
      Quote(id: '1', author: 'John Cena', content: 'A quote')
    ];
    when(() => mockRepository.getQuotes())
        .thenAnswer((_) async => const Right(repoResponse));
    // act
    final result = await useCase.call(NoParams());
    // assert
    verify(() => mockRepository.getQuotes());
    expect(result, const Right(repoResponse));
  });
}
