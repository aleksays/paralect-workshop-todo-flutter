import 'package:dio/dio.dart';
import 'package:workshop_app/features/todos/models/todo_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  ));

  Future<List<TodoModel>> fetchTodos() async {
    final response = await _dio.get('/todos');
    return (response.data as List)
        .map((json) => TodoModel.fromJson(json))
        .toList();
  }

  Future<TodoModel> createTodo(String title) async {
    final response = await _dio.post('/todos', data: {
      'title': title,
      'completed': false,
    });
    return TodoModel.fromJson(response.data);
  }

  Future<void> deleteTodo(int id) async {
    await _dio.delete('/todos/$id');
  }
}
