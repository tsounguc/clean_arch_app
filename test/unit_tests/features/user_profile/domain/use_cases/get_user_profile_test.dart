import 'package:clean_arch_app/core/errors/failures.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/domain/repositories/user_repository.dart';
import 'package:clean_arch_app/features/user_profile/domain/use_cases/get_user_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserRepository repository;
  late GetUserProfile getPostsUseCase;

  setUp(() {
    repository = MockUserRepository();
    getPostsUseCase = GetUserProfile(repository);
  });

  const testResponse = User(id: 0, name: '_empty.name');
  const params = '_empty.userId';
  const testFailure = Failure('message');

  group('GetUserProfile', () {
    test(
      'given GetUserProfile '
      'when instantiated '
      'then call [UserRepository.getUserById] '
      'and return [User]',
      () async {
        // Arrange
        when(() => repository.getUserById(params)).thenAnswer((_) async => const Right(testResponse));

        // Act
        final result = await getPostsUseCase(params);

        // Assert
        expect(result, equals(const Right<Failure, User>(testResponse)));
        verify(() => repository.getUserById(params)).called(1);
        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'given GetUserProfile '
      'when instantiated '
      'and [UserRepository.getUserById] call unsuccessful'
      'then return [Failure]',
      () async {
        // Arrange
        when(() => repository.getUserById(params)).thenAnswer((_) async => const Left(testFailure));

        // Act
        final result = await getPostsUseCase(params);

        // Assert
        expect(result, equals(const Left<Failure, User>(testFailure)));
        verify(() => repository.getUserById(params)).called(1);
        verifyNoMoreInteractions(repository);
      },
    );
  });
}
