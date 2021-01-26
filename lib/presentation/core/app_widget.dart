import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_todos/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter_ddd_todos/presentation/sign_in/sign_in_page.dart';

import '../../injections.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SignInFormBloc>(),
        )
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: SignInPage(),
      ),
    );
  }
}
