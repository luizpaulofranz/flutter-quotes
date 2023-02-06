import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? errorCode;
  final String? errorMessage;

  const Failure({this.errorCode, this.errorMessage});

  @override
  List get props => [errorCode, errorMessage];
}
