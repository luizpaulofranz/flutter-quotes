import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class QuoteDataSource {
  Future<List<Quote>> getQuotes();
}
