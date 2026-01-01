import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl();

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    return const Left(UnknownFailure('Not implemented yet'));
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    return const Left(UnknownFailure('Not implemented yet'));
  }
}
