import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/local_cache/local_cache_service.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/use_cases/get_quotes_use_case.dart';
import 'package:quotes/features/quotes/presentation/bloc/quotes_event.dart';
import 'package:quotes/features/quotes/presentation/bloc/quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  late final GetQuotesUseCase getQuotesUseCase;
  late final LocalCacheService localCache;

  QuotesBloc(this.getQuotesUseCase, this.localCache) : super(EmptyState()) {
    on<GetQuotes>((event, emit) async => emit(await getQuotes()));
  }

  Future<QuotesState> getQuotes() async {
    final cachedQuotes = localCache.getCacheData<List<Quote>>(key: quotesKey);
    if (cachedQuotes != null && cachedQuotes.isNotEmpty) {
      return LoadedState(quotes: cachedQuotes);
    }

    final failOrSuccess = await getQuotesUseCase(NoParams());
    return failOrSuccess.fold(
      (fail) => ErrorState(message: fail.errorMessage ?? "Unexpected error."),
      (quotes) {
        localCache.setCacheData(key: quotesKey, value: quotes);
        return LoadedState(quotes: quotes);
      },
    );
  }
}
