import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_app/enums/todos_filter.dart';
import 'package:workshop_app/features/todos/api_service.dart';
import 'package:workshop_app/features/todos/models/todo_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final ApiService apiService = ApiService();
  TodosState? previousState;

  TodosBloc() : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodo>(_onToggleTodo);
    on<FilterTodos>(_onFilterTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await apiService.fetchTodos();
      emit(TodoLoaded(todos: todos, filteredTodos: todos));
    } catch (e) {
      emit(const TodoError("Failed to load todos"));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final newTodo = TodoModel(
        id: currentState.todos.length + 1,
        title: event.title,
        completed: false,
      );
      final List<TodoModel> updatedTodos = [newTodo, ...currentState.todos];
      emit(_mapFilterToState(currentState.filter, updatedTodos));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) async {
    try {
      await apiService.deleteTodo(event.id);
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final updatedTodos =
            currentState.todos.where((todo) => todo.id != event.id).toList();
        emit(_mapFilterToState(currentState.filter, updatedTodos));
      }
    } catch (e) {
      emit(const TodoError("Failed to delete todo"));
    }
  }

  void _onToggleTodo(ToggleTodo event, Emitter<TodosState> emit) async {
    try {
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final updatedTodos = currentState.todos.map((todo) {
          return todo.id == event.todo.id
              ? event.todo.copyWith(completed: !event.todo.completed)
              : todo;
        }).toList();
        emit(_mapFilterToState(currentState.filter, updatedTodos));
      }
    } catch (e) {
      emit(const TodoError("Failed to toggle todo"));
    }
  }

  void _onFilterTodos(FilterTodos event, Emitter<TodosState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(_mapFilterToState(event.filter, currentState.todos));
    }
  }

  TodoLoaded _mapFilterToState(TodosFilter filter, List<TodoModel> todos) {
    List<TodoModel> filteredTodos;
    switch (filter) {
      case TodosFilter.completed:
        filteredTodos = todos.where((todo) => todo.completed).toList();
        break;
      case TodosFilter.uncompleted:
        filteredTodos = todos.where((todo) => !todo.completed).toList();
        break;
      case TodosFilter.all:
      default:
        filteredTodos = todos;
    }
    return TodoLoaded(
      todos: todos,
      filteredTodos: filteredTodos,
      filter: filter,
    );
  }
}
