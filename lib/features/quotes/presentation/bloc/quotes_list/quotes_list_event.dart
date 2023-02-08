import 'package:equatable/equatable.dart';

abstract class ListQuotesEvent extends Equatable {
  const ListQuotesEvent();

  @override
  List<Object> get props => [];
}

class GetQuotes extends ListQuotesEvent {}
