import 'package:equatable/equatable.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

abstract class SingleQuoteState extends Equatable {
  const SingleQuoteState();

  @override
  List<Object> get props => [];
}

class EmptyState extends SingleQuoteState {}

class LoadingState extends SingleQuoteState {}

class LoadedState extends SingleQuoteState {
  final Quote quote;

  const LoadedState({required this.quote});

  @override
  List<Object> get props => [quote];
}

class ErrorState extends SingleQuoteState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
