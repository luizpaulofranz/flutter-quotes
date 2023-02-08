import 'package:equatable/equatable.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class SingleQuoteEvent extends Equatable {
  const SingleQuoteEvent();

  @override
  List<Object> get props => [];
}

class DeleteQuote extends SingleQuoteEvent {
  final Quote quote;

  const DeleteQuote(this.quote);

  @override
  List<Object> get props => [quote];
}

class UpdateQuote extends SingleQuoteEvent {
  final Quote quote;

  const UpdateQuote(this.quote);

  @override
  List<Object> get props => [quote];
}
