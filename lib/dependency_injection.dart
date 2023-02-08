import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quotes/core/local_cache/local_cache_service.dart';
import 'package:quotes/core/local_cache/local_cache_service_impl.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source_impl.dart';
import 'package:quotes/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/features/quotes/domain/use_cases/delete_quote_use_case.dart';
import 'package:quotes/features/quotes/domain/use_cases/get_quotes_use_case.dart';
import 'package:quotes/features/quotes/domain/use_cases/update_quote_use_case.dart';
import 'package:quotes/features/quotes/presentation/bloc/quotes_list/quotes_list_bloc.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_bloc.dart';

final di = GetIt.instance;

// THIS IS CALLED ON main.dart, at the very beginning.
Future<void> registerDI() async {
  // Bloc
  di.registerFactory<ListQuotesBloc>(
    () => ListQuotesBloc(di()),
  );
  di.registerFactory<SingleQuoteBloc>(
    () => SingleQuoteBloc(di(), di()),
  );

  // UseCases
  di.registerLazySingleton<GetQuotesUseCase>(
    () => GetQuotesUseCase(di()),
  );
  di.registerLazySingleton<UpdateQuotesUseCase>(
    () => UpdateQuotesUseCase(di()),
  );
  di.registerLazySingleton<DeleteQuotesUseCase>(
    () => DeleteQuotesUseCase(di()),
  );

  // Service
  di.registerLazySingleton<LocalCacheService>(
    () => LocalCacheServiceImpl(),
  );

  // Repository
  di.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(di(), di()),
  );

  // DataSource
  di.registerLazySingleton<QuoteDataSource>(
    () => QuoteDataSourceImpl(
      client: di(),
    ),
  );

  // External
  di.registerLazySingleton<Dio>(() => Dio());
}
