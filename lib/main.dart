import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quotes/core/usecase/usecase.dart';
import 'package:quotes/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/quotes/domain/use_cases/get_quotes_use_case.dart';

import 'features/quotes/data/data_sources/quote_data_source_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    test();
    super.initState();
  }

  void test() {
    final ds = QuoteDataSourceImpl(client: Dio());
    final repo = QuoteRepositoryImpl(ds);
    final useCase = GetQuotesUseCase(repo);
    print('Akiii');
    useCase.call(NoParams()).then((either) {
      either.fold(
        (failure) {
          print('Noops :-(');
        },
        (trivia) {
          print('Funcionou!');
        },
      );
      // if(either.isRight()) {
      //   print('Funcionou!');
      //   // either.
      // } else {
      //   print('Noops :-(');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
