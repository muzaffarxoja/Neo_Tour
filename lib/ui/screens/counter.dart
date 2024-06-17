// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => Counter(),
//       child: const MaterialApp(
//         home: CounterPage(),
//       ),
//     );
//   }
// }
//
// class CounterPage extends StatelessWidget {
//   const CounterPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final counter = Provider.of<Counter>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider Counter App'),
//       ),
//       body: Center(
//         child: Text('Counter: ${counter.count}'),
//       ),
//       floatingActionButton: Column(
//
//           children: [
//             FloatingActionButton(
//               onPressed: counter.increment,
//               tooltip: 'Increment',
//               child: const Icon(Icons.add),),
//
//             FloatingActionButton(
//               onPressed: counter.decrement,
//               tooltip: 'Decrement',
//               child: const Icon(Icons.add_chart),),
//
//
//           ]
//       ),
//     );
//   }
// }
// // Provider
//
// class Counter extends ChangeNotifier {
//   int _count = 0;
//
//   int get count => _count;
//
//   void increment() {
//     _count++;
//     notifyListeners();
//   }
//
//   void decrement() {
//     _count--;
//     notifyListeners();
//   }
//
// }
//
//
//
