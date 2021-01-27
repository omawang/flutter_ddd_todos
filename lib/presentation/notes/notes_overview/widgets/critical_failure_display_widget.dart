import 'package:flutter/material.dart';
import 'package:flutter_ddd_todos/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure failure;

  const CriticalFailureDisplay({
    Key key,
    @required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('😱', style: TextStyle(fontSize: 100)),
          Text(
            failure.maybeMap(
              insufficientPermission: (_) => 'Insufficient permission',
              orElse: () => 'Unexpected error. \nPlease contact support.',
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
