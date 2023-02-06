import 'package:quotes/features/quotes/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({String? id, String? author, String? content})
      : super(id: id, author: author, content: content);

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['_id'],
      author: json['author'],
      content: json['content'],
    );
  }
}
