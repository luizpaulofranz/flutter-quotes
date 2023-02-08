import 'package:dartz/dartz.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/core/local_cache/local_cache_service.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteDataSource _dataSource;
  final LocalCacheService _localCache;

  QuoteRepositoryImpl(this._dataSource, this._localCache);

  @override
  Future<Either<Failure, List<Quote>>> getQuotes() async {
    final cachedQuotes = _localCache.getCacheData(key: quotesKey);
    if (cachedQuotes?.isNotEmpty ?? false) {
      return Right(cachedQuotes);
    }
    try {
      final modelQuotes = await _dataSource.getQuotes();
      final quotes = modelQuotes
          .map(
            (model) => Quote(
              id: model.id,
              author: model.author,
              content: model.content,
            ),
          )
          .toList();
      _localCache.setCacheData(key: quotesKey, value: quotes);
      return Right(quotes);
    } on ApiException catch (apiException) {
      return Left(Failure(errorMessage: apiException.message));
    } catch (_) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Quote>> deleteQuote(Quote quote) async {
    final cachedQuotes = _localCache.getCacheData<List<Quote>>(key: quotesKey);
    if (cachedQuotes == null) {
      return Right(quote);
    }
    cachedQuotes.remove(quote);
    _localCache.clearCache();
    _localCache.setCacheData(key: quotesKey, value: cachedQuotes);
    return Right(quote);
  }

  @override
  Future<Either<Failure, Quote>> updateQuote(Quote quote) async {
    final cachedQuotes = _localCache.getCacheData<List<Quote>>(key: quotesKey);
    final index = cachedQuotes?.indexWhere((element) => element.id == quote.id);
    if (index == null) {
      return Right(quote);
    }
    cachedQuotes?.replaceRange(index, index + 1, [quote]);
    _localCache.clearCache();
    _localCache.setCacheData(key: quotesKey, value: cachedQuotes);
    return Right(quote);
  }
}
