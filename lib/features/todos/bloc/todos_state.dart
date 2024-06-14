part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodosState {}

class TodoLoading extends TodosState {}

class TodoLoaded extends TodosState {
  final List<TodoModel> todos;
  final List<TodoModel> filteredTodos;
  final TodosFilter filter;

  const TodoLoaded({
    required this.todos,
    required this.filteredTodos,
    this.filter = TodosFilter.all,
  });

  @override
  List<Object?> get props => [todos, filteredTodos, filter];
}

class TodoError extends TodosState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}
