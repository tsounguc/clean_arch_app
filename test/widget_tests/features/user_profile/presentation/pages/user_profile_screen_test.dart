import 'package:clean_arch_app/core/services/service_locator.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/presentation/pages/user_profile_screen.dart';
import 'package:clean_arch_app/features/user_profile/presentation/user_profile_cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfileCubit extends Mock implements UserProfileCubit {}

void main() {
  late UserProfileCubit cubit;

  setUp(() {
    cubit = MockUserProfileCubit();
    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
  });

  // tearDown(() => serviceLocator.reset());

  const user = User(id: 0, name: '_empty.name');

  // this is so we don't have to
  // write MaterialApp for every test
  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider.value(
        value: cubit,
        child: const UserProfileScreen(),
      ),
    );
  }

  group('UserProfileScreen', () {
    testWidgets(
      'given UserProfileScreen'
      'when material app opens UserProfileScreen '
      'and state is UserProfileInitial '
      'then render a loading indicator ',
      (tester) async {
        // Arrange
        when(() => cubit.state).thenReturn(const UserProfileInitial());

        // Act
        await tester.pumpWidget(createTestWidget());

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'given UserProfileScreen '
      'when material app opens UserProfileScreen '
      'and state is LoadingUserProfile '
      'then render a loading indicator ',
      (tester) async {
        // Arrange
        when(() => cubit.state).thenReturn(const LoadingUserProfile());

        // Act
        await tester.pumpWidget(createTestWidget());

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'given UserProfileScreen '
      'when material app opens UserProfileScreen '
      'and state is UserProfileError '
      'then display error message ',
      (tester) async {
        // Arrange
        const errorMessage = 'Failed to fetch user';
        when(() => cubit.state).thenReturn(
          const UserProfileError(message: errorMessage),
        );

        // Act
        await tester.pumpWidget(createTestWidget());

        // Assert
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'given UserProfileScreen '
      'when material app opens UserProfileScreen '
      'and state is UserProfileLoaded '
      'then display user name',
      (tester) async {
        // Arrange

        when(() => cubit.state).thenReturn(
          const UserProfileLoaded(user: user),
        );

        // Act
        await tester.pumpWidget(createTestWidget());

        // Assert
        expect(find.text('Hello, ${user.name}!'), findsOneWidget);
      },
    );
  });
}
