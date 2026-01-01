import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';

/// Todo repository interface
abstract class TodoRepository {
  /// Get all todos
  Future<Either<Failure, List<Todo>>> getTodos();

  /// Get todo by id
  Future<Either<Failure, Todo>> getTodoById(String id);

  /// Create todo
  Future<Either<Failure, Todo>> createTodo(Todo todo);

  /// Update todo
  Future<Either<Failure, Todo>> updateTodo(Todo todo);

  /// Delete todo
  Future<Either<Failure, void>> deleteTodo(String id);
}
