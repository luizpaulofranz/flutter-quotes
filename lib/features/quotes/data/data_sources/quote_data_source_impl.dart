import 'package:dio/dio.dart';
import 'package:quotes/core/failures/exceptions.dart';
import 'package:quotes/features/quotes/data/data_sources/quote_data_source.dart';
import 'package:quotes/features/quotes/data/models/quote_model.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';

const quotesUrl = "https://quotable.io/quotes?page=1&limit=10";

class QuoteDataSourceImpl implements QuoteDataSource {
  final Dio client;

  QuoteDataSourceImpl({required this.client});

  @override
  Future<List<Quote>> getQuotes() async {
    Response response;
    try {
      response = await client.get(quotesUrl);
    } on DioError catch (dioError) {
      throw ApiException(
        message:
            "StatusCode: ${dioError.response?.statusCode} - ${dioError.message}",
      );
    } catch (_) {
      throw const ApiException();
    }

    final Map<String, dynamic> data = response.data;
    if (data['results'] == null || data['results'] is! List) {
      throw const ApiException(message: "Server changed their response body.");
    }

    final List results = data['results'];

    if (results.isEmpty) {
      return [];
    }

    final quotes = results.map((q) {
      return QuoteModel.fromJson(q);
    }).toList();

    return quotes;
  }
}
