import 'package:flutter/material.dart';
import 'package:flutter_ddd_todos/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SignInPage(),
    );
  }
}
