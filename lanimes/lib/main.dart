import 'package:flutter/material.dart';
import 'package:lanimes/services/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //ESTRUTURA TEMPORÁRIA

  final void Function() onClick = () async {
    Api api = Api();
    final result = await api.registerNewUser("username", "senha12345");
    print(result.data);
    final result2 = await api.loginWithUsernameAndPassword("username", "senha12345");
    print(result2.data);
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LAnimes",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: InkWell(
            onTap: onClick,
            child: Text("Click-me"),
          ),
        ),
      ),
    );
  }
}