import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_todos/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_ddd_todos/domain/notes/value_objects.dart';
import 'package:flutter_ddd_todos/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:flutter_ddd_todos/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
            message: 'Want longer lists? Activate premium 😍',
            button: FlatButton(
              onPressed: () {},
              child: const Text(
                'Buy Now',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            duration: const Duration(seconds: 5),
          ).show(context);
        }
      },
      child: Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: formTodos.value.size,
            itemBuilder: (context, index) {
              return TodoTile(
                index: index,
                key: ValueKey(
                  context.formTodos[index].id,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());

    final textEditingController = useTextEditingController(text: todo.name);

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            context.formTodos = context.formTodos.minusElement(todo);
            context
                .read<NoteFormBloc>()
                .add(NoteFormEvent.todosChanged(context.formTodos));
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              context.formTodos = context.formTodos.map((listTodo) =>
                  listTodo == todo ? todo.copyWith(done: value) : listTodo);

              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
          ),
          title: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Todo',
              counterText: '',
              border: InputBorder.none,
            ),
            maxLength: TodoName.maxLength,
            onChanged: (value) {
              context.formTodos = context.formTodos.map((listTodo) =>
                  listTodo == todo ? todo.copyWith(name: value) : listTodo);

              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
            validator: (_) {
              return context.read<NoteFormBloc>().state.note.todos.value.fold(
                    (f) => null,
                    (todoList) => todoList[index].name.value.fold(
                          (f) => f.maybeMap(
                            empty: (_) => 'Cannot be empty',
                            exceedingLength: (_) => 'Too long',
                            multiline: (_) => 'Has to be a single line',
                            orElse: () => null,
                          ),
                          (_) => null,
                        ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
