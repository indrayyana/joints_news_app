import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/ui/news_screen.dart';

import 'bloc/news_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(NewsGetEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NewsScreen(),
      ),
    );
  }
}
