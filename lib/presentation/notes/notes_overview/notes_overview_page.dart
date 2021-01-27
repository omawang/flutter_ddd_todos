import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_todos/application/auth/auth_bloc.dart';
import 'package:flutter_ddd_todos/application/notes/note_actor/note_actor_bloc.dart';
import 'package:flutter_ddd_todos/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter_ddd_todos/injections.dart';
import 'package:flutter_ddd_todos/presentation/routes/router.gr.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<NoteWatcherBloc>()),
        BlocProvider(create: (context) => getIt<NoteActorBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) {
                  ExtendedNavigator.of(context).replace(Routes.signInPage);
                },
                orElse: () {},
              );
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
              deleteFailure: (state) {
                FlushbarHelper.createError(
                  message: state.noteFailure.map(
                    unexpected: (_) =>
                        'Unexpected error occured while deleting, please contact support',
                    insufficientPermission: (_) => 'Unsufficient permissions ✖',
                    unableToUpdate: (_) => 'Impossible error',
                  ),
                ).show(context);
              },
              orElse: () {},
            );
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.indeterminate_check_box),
                onPressed: () {},
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: navigate to NoteFormPage
            },
            child: const Icon(Icons.add),
          ),
          body: const Center(
            child: Text('a'),
          ),
        ),
      ),
    );
  }
}
