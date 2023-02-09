import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/dependency_injection.dart';
import 'package:quotes/features/quotes/presentation/bloc/list_quotes/list_quotes_bloc.dart';
import 'package:quotes/features/quotes/presentation/bloc/single_quote/single_quote_bloc.dart';

import 'features/quotes/presentation/screen/quotes_list_screen.dart';

void main() async {
  // register all dependencies
  WidgetsFlutterBinding.ensureInitialized();
  await registerDI();

  runApp(const Quotes());
}

class Quotes extends StatelessWidget {
  const Quotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListQuotesBloc>(create: (_) => di()),
        BlocProvider<SingleQuoteBloc>(create: (_) => di()),
      ],
      child: MaterialApp(
        title: 'Quotes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        // home: MyHomePage(title:""),
        home: const QuotesListScreen(),
      ),
    );
  }
}
