part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodosEvent {}

class AddTodo extends TodosEvent {
  final String title;

  const AddTodo(this.title);

  @override
  List<Object?> get props => [title];
}

class DeleteTodo extends TodosEvent {
  final int id;

  const DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTodo extends TodosEvent {
  final TodoModel todo;

  const ToggleTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class FilterTodos extends TodosEvent {
  final TodosFilter filter;

  const FilterTodos(this.filter);

  @override
  List<Object> get props => [filter];
}
