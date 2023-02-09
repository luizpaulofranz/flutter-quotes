import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/domain/use_cases/get_quotes_use_case.dart';

import 'list_quotes_event.dart';
import 'list_quotes_state.dart';

class ListQuotesBloc extends Bloc<ListQuotesEvent, ListQuotesState> {
  late final GetQuotesUseCase getQuotesUseCase;

  ListQuotesBloc(
    this.getQuotesUseCase,
  ) : super(EmptyState()) {
    on<GetQuotes>((event, emit) async => emit(await getQuotes()));
  }

  Future<ListQuotesState> getQuotes() async {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(LoadingState());
    final failOrSuccess = await getQuotesUseCase(NoParams());
    return failOrSuccess.fold(
      (fail) => ErrorState(message: fail.errorMessage ?? "Unexpected error."),
      (quotes) {
        return LoadedState(quotes: quotes);
      },
    );
  }
}
