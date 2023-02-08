import 'package:equatable/equatable.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class GetQuotes extends QuotesEvent {}

class GetSingleQuote extends QuotesEvent {
  final Quote quote;

  const GetSingleQuote(this.quote);

  @override
  List<Object> get props => [quote];
}
