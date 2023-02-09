import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/components/custom_app_bar.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_bloc.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_event.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_state.dart';
import 'package:quotes/features/quotes/presentation/screen/single_quote_screen.dart';

class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({super.key});

  @override
  State<QuotesListScreen> createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListQuotesBloc>().add(GetQuotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: BlocBuilder<ListQuotesBloc, ListQuotesState>(
            builder: (context, state) {
          if (state is EmptyState || state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }
          final quotes = (state as LoadedState).quotes;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              child: ListView.separated(
                  itemCount: quotes.length,
                  separatorBuilder: (context, index) => const Divider(
                        height: 2,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        quotes[index].content ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(quotes[index].author ?? ""),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () => Navigator.of(context)
                          .push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  SingleQuotesScreen(quote: quotes[index]),
                            ),
                          )
                          .then((_) =>
                              context.read<ListQuotesBloc>().add(GetQuotes())),
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
