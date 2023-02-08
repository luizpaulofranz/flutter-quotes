import 'package:dartz/dartz.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';

class UpdateQuotesUseCase extends Usecase<Quote, Quote> {
  final QuoteRepository _repository;

  UpdateQuotesUseCase(this._repository);

  @override
  Future<Either<Failure, Quote>> call(Quote params) {
    return _repository.updateQuote(params);
  }
}
