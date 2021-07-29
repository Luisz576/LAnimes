import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:lanimes/blocs/UserBloc.dart';
import 'package:lanimes/screens/home_screen.dart';
import 'package:lanimes/screens/login_screen.dart';

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
        bloc: UserBloc(),
        child: PageView(//TODO: Usar bloc para controle de página?
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            LoginScreen(_pageController),
            HomeScreen(_pageController),
          ],
        ),
      ),
    );
  }
}