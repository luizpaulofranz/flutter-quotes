import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/domain/use_cases/get_quotes_use_case.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_bloc.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_event.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_state.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetQuotesUseCase extends Mock implements GetQuotesUseCase {}

void main() {
  late ListQuotesBloc bloc;
  late MockGetQuotesUseCase mockGetQuotesUseCase;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetQuotesUseCase = MockGetQuotesUseCase();
    bloc = ListQuotesBloc(mockGetQuotesUseCase);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  test(
    'should call the GetQuotesUseCase in order to return the list of quotes',
    () async {
      // arrange
      final quotesList = getQuotesList();
      when(
        () => mockGetQuotesUseCase.call(any()),
      ).thenAnswer(
        (invocation) async => Right(quotesList),
      );
      // act
      bloc.add(GetQuotes());
      await untilCalled(() => mockGetQuotesUseCase.call(any()));
      // assert
      verify(() => mockGetQuotesUseCase.call(NoParams()));
    },
  );

  test(
    'should call the GetQuotesUseCase and return an API error',
    () async {
      // arrange
      when(
        () => mockGetQuotesUseCase.call(any()),
      ).thenAnswer(
        (invocation) async => const Left(Failure(errorMessage: 'my error')),
      );
      final expected = [
        LoadingState(),
        const ErrorState(message: 'my error'),
      ];
      // in this case, we assert before, a trick when dealing with bloc
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetQuotes());
    },
  );
}
