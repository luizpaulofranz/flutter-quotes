import 'package:dartz/dartz.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, List<Quote>>> getQuotes();
  Future<Either<Failure, Quote>> updateQuote(Quote quote);
  Future<Either<Failure, Quote>> deleteQuote(Quote quote);
}
