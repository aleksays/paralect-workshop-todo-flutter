import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_app/features/todos/bloc/todos_bloc.dart';
import 'package:workshop_app/features/todos/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Todo'),
              content: const Text('Are you sure you want to delete this todo?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(DeleteTodo(todo.id));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: ListTile(
        leading: todo.completed
            ? Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              )
            : Icon(
                Icons.crop_square_outlined,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed
                ? Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.65)
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        onTap: () {
          context.read<TodosBloc>().add(ToggleTodo(todo));
        },
      ),
    );
  }
}
