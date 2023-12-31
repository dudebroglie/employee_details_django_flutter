import 'package:flutter/material.dart';

import './screens/home.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Django',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}
