import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/use_cases/delete_quote_use_case.dart';
import 'package:quotes/features/quotes/domain/use_cases/update_quote_use_case.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_bloc.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_event.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_state.dart';

class MockDeleteQuotesUseCase extends Mock implements DeleteQuotesUseCase {}

class MockUpdateQuotesUseCase extends Mock implements UpdateQuotesUseCase {}

void main() {
  late SingleQuoteBloc bloc;
  late MockDeleteQuotesUseCase mockDeleteQuotesUseCase;
  late MockUpdateQuotesUseCase mockUpdateQuotesUseCase;

  setUpAll(() {
    registerFallbackValue(const Quote());
  });

  setUp(() {
    mockDeleteQuotesUseCase = MockDeleteQuotesUseCase();
    mockUpdateQuotesUseCase = MockUpdateQuotesUseCase();
    bloc = SingleQuoteBloc(mockUpdateQuotesUseCase, mockDeleteQuotesUseCase);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group('DeleteQuote Event Tests', () {
    test(
      'should call the DeleteQuotesUseCase and emit a LoadedState when returns success',
      () async {
        // arrange
        const quoteTest =
            Quote(id: '1', author: 'John Cena', content: 'a simple quote');
        when(
          () => mockDeleteQuotesUseCase.call(any()),
        ).thenAnswer(
          (_) async => const Right(quoteTest),
        );
        final expectedStates = [
          const LoadedState(quote: quoteTest),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedStates));
        // act
        bloc.add(const DeleteQuote(quoteTest));
        await untilCalled(() => mockDeleteQuotesUseCase.call(any()));
        // assert
        verify(() => mockDeleteQuotesUseCase.call(quoteTest));
      },
    );

    test(
      'should call the DeleteQuotesUseCase and emit a ErrorState when something went wrong',
      () async {
        // arrange
        const quoteTest =
            Quote(id: '1', author: 'John Cena', content: 'a simple quote');
        when(
          () => mockDeleteQuotesUseCase.call(any()),
        ).thenAnswer(
          (_) async => const Left(Failure(errorMessage: 'error')),
        );
        final expectedStates = [
          const ErrorState(message: 'error'),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedStates));
        // act
        bloc.add(const DeleteQuote(quoteTest));
        await untilCalled(() => mockDeleteQuotesUseCase.call(any()));
        // assert
        verify(() => mockDeleteQuotesUseCase.call(quoteTest));
      },
    );
  });

  group('UpdateQuote Event Tests', () {
    test(
      'should call the UpdateQuotesUseCase and emit a LoadedState when returns success',
      () async {
        // arrange
        const quoteTest =
            Quote(id: '1', author: 'John Cena', content: 'a simple quote');
        when(
          () => mockUpdateQuotesUseCase.call(any()),
        ).thenAnswer(
          (_) async => const Right(quoteTest),
        );
        final expectedStates = [
          const LoadedState(quote: quoteTest),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedStates));
        // act
        bloc.add(const UpdateQuote(quoteTest));
        await untilCalled(() => mockUpdateQuotesUseCase.call(any()));
        // assert
        verify(() => mockUpdateQuotesUseCase.call(quoteTest));
      },
    );

    test(
      'should call the UpdateQuotesUseCase and emit a ErrorState when something went wrong',
      () async {
        // arrange
        const quoteTest =
            Quote(id: '1', author: 'John Cena', content: 'a simple quote');
        when(
          () => mockUpdateQuotesUseCase.call(any()),
        ).thenAnswer(
          (_) async => const Left(Failure(errorMessage: 'error')),
        );
        final expectedStates = [
          const ErrorState(message: 'error'),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedStates));
        // act
        bloc.add(const UpdateQuote(quoteTest));
        await untilCalled(() => mockUpdateQuotesUseCase.call(any()));
        // assert
        verify(() => mockUpdateQuotesUseCase.call(quoteTest));
      },
    );
  });
}
