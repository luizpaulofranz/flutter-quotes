import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/dependency_injection.dart';
import 'package:quotes/features/quotes/presentation/bloc/quotes_list/quotes_list_bloc.dart';
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     test();
//   }

//   @override
//   void initState() {
//     test();
//     super.initState();
//   }

//   void test() {
//     final ds = QuoteDataSourceImpl(client: Dio());
//     final repo = QuoteRepositoryImpl(ds);
//     final useCase = GetQuotesUseCase(repo);
//     print('Akiii');
//     useCase.call(NoParams()).then((either) {
//       either.fold(
//         (failure) {
//           print('Noops :-(');
//         },
//         (trivia) {
//           print('Funcionou!');
//           trivia.forEach((element) {
//             print(element.id);
//           });
//         },
//       );
//       // if(either.isRight()) {
//       //   print('Funcionou!');
//       //   // either.
//       // } else {
//       //   print('Noops :-(');
//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: test,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
