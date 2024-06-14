import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_app/enums/todos_filter.dart';
import 'package:workshop_app/features/todos/bloc/todos_bloc.dart';
import 'package:workshop_app/widgets/add_todo_action.dart';
import 'package:workshop_app/widgets/custom_app_bar.dart';
import 'package:workshop_app/widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Todos',
          tabBar: TabBar(
            tabs: const [
              Tab(text: 'All todos'),
              Tab(text: 'Completed'),
              Tab(text: 'Uncompleted'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {
              final filter = TodosFilter.values[index];
              context.read<TodosBloc>().add(FilterTodos(filter));
            },
          ),
        ),
        body: BlocListener<TodosBloc, TodosState>(
          listener: (context, state) {
            if (state is TodoLoaded) {
              final todos = state.todos;
              final previousState = context.read<TodosBloc>().previousState;

              if (previousState != null && previousState is TodoLoaded) {
                final previousTodos = previousState.todos;

                if (previousTodos.length < todos.length) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'New item added successfully',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green.shade300,
                    ),
                  );
                } else if (previousTodos.length > todos.length) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Item was deleted',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }

              context.read<TodosBloc>().previousState = state;
            }
          },
          child: BlocBuilder<TodosBloc, TodosState>(
            builder: (context, state) {
              if (state is TodoInitial) {
                context.read<TodosBloc>().add(LoadTodos());
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodoLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Colors.blueGrey.shade100,
                  ),
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.filteredTodos[index];
                    return TodoItem(todo: todo);
                  },
                );
              } else if (state is TodoError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
        floatingActionButton: const AddTodoAction(),
      ),
    );
  }
}
