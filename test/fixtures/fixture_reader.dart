import 'dart:convert';
import 'dart:io';

import 'package:quotes/features/quotes/data/models/quote_model.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

List<Quote> getQuotesList() {
  final jsonData = jsonDecode(fixture('quotes.json'));
  return (jsonData["results"] as List)
      .map((q) => QuoteModel.fromJson(q))
      .map((e) => Quote(id: e.id, author: e.author, content: e.content))
      .toList();
}
