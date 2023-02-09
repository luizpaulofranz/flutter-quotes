import 'package:equatable/equatable.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class ListQuotesState extends Equatable {
  const ListQuotesState();

  @override
  List<Object> get props => [];
}

class EmptyState extends ListQuotesState {}

class LoadingState extends ListQuotesState {}

class LoadedState extends ListQuotesState {
  final List<Quote> quotes;

  const LoadedState({required this.quotes});

  @override
  List<Object> get props => [quotes];
}

class ErrorState extends ListQuotesState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
