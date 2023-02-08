import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/use_cases/delete_quote_use_case.dart';
import 'package:quotes/features/quotes/domain/use_cases/update_quote_use_case.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_event.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_state.dart';

class SingleQuoteBloc extends Bloc<SingleQuoteEvent, SingleQuoteState> {
  late final UpdateQuotesUseCase updateQuotesUseCase;
  late final DeleteQuotesUseCase deleteQuotesUseCase;

  SingleQuoteBloc(
    this.updateQuotesUseCase,
    this.deleteQuotesUseCase,
  ) : super(EmptyState()) {
    on<UpdateQuote>(
        (event, emit) async => emit(await updateQuote(event.quote)));
    on<DeleteQuote>(
        (event, emit) async => emit(await deleteQuote(event.quote)));
  }

  Future<SingleQuoteState> updateQuote(Quote quote) async {
    final failOrSuccess = await updateQuotesUseCase(quote);
    return failOrSuccess.fold(
      (fail) => ErrorState(message: fail.errorMessage ?? "Unexpected error."),
      (quote) {
        return LoadedState(quote: quote);
      },
    );
  }

  Future<SingleQuoteState> deleteQuote(Quote quote) async {
    final failOrSuccess = await deleteQuotesUseCase(quote);
    return failOrSuccess.fold(
      (fail) => ErrorState(message: fail.errorMessage ?? "Unexpected error."),
      (quote) {
        return LoadedState(quote: quote);
      },
    );
  }
}
