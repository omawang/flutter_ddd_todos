import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_todos/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter_ddd_todos/application/auth_bloc.dart';
import 'package:flutter_ddd_todos/presentation/routes/router.gr.dart'
    as app_router;

import '../../injections.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequest()),
        ),
        BlocProvider(
          create: (context) => getIt<SignInFormBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        builder: ExtendedNavigator.builder(router: app_router.Router()),
      ),
    );
  }
}
