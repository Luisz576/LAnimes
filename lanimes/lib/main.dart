import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:lanimes/blocs/UserBloc.dart';
import 'package:lanimes/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LAnimes",
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        bloc: UserBloc(), //As preferências do usuário são globais
        child: HomeScreen(_pageController),
      ),
    );
  }
}