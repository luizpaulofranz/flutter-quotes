import 'package:dartz/dartz.dart';
import 'package:quotes/core/failures/failure.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/domain/repositories/quote_repository.dart';

class GetQuotesUseCase extends Usecase<List<Quote>, NoParams> {
  final QuoteRepository _repository;

  GetQuotesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Quote>>> call(NoParams params) {
    return _repository.getQuotes();
  }
}
