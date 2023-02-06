import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String? id;
  final String? author;
  final String? content;

  const Quote({
    this.id,
    this.author,
    this.content,
  });

  @override
  List<Object?> get props => [id, author, content];
}
