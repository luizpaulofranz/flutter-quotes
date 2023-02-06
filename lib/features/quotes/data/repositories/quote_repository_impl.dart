import 'package:dartz/dartz.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteDataSource _dataSource;

  QuoteRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<Quote>>> getQuotes() async {
    try {
      final quotes = await _dataSource.getQuotes();
      return Right(quotes);
    } on ApiException catch (apiException) {
      return Left(Failure(errorMessage: apiException.message));
    } catch (_) {
      return const Left(Failure());
    }
  }
}
