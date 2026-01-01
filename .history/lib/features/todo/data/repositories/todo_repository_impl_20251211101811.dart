import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

/// Todo repository implementation
class TodoRepositoryImpl implements TodoRepository {
  // TODO: Add data sources when backend is implemented

  TodoRepositoryImpl();

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    // TODO: Implement when backend is ready
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    // TODO: Implement when backend is ready
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    // TODO: Implement when backend is ready
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    // TODO: Implement when backend is ready
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    // TODO: Implement when backend is ready
    return const Left(UnknownFailure('Not implemented yet'));
  }
}
