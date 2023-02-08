import 'package:equatable/equatable.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class EmptyState extends QuotesState {}

class LoadingState extends QuotesState {}

class LoadedState extends QuotesState {
  final List<Quote> quotes;

  const LoadedState({required this.quotes});

  @override
  List<Object> get props => [quotes];
}

class ErrorState extends QuotesState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
