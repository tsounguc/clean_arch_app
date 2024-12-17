import 'package:clean_arch_app/core/errors/failures.dart';
import 'package:clean_arch_app/core/services/service_locator.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/domain/repositories/user_repository.dart';
import 'package:clean_arch_app/features/user_profile/domain/use_cases/get_user_profile.dart';
import 'package:clean_arch_app/features/user_profile/presentation/user_profile_cubit/user_profile_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:clean_arch_app/main.dart' as app;
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserProfileCubit extends Mock implements UserProfileCubit {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late UserRepository repository;
  late UserProfileCubit cubit;

  setUp(() {
    // Ensure existing dependency is removed before registering a new one
    if (serviceLocator.isRegistered<UserRepository>()) {
      serviceLocator.unregister<UserRepository>();
    }

    if (serviceLocator.isRegistered<UserProfileCubit>()) {
      serviceLocator.unregister<UserProfileCubit>();
    }

    // Register mock dependencies
    repository = MockUserRepository();
    serviceLocator.registerSingleton<UserRepository>(repository);

    // Register a real or mock UserProfileCubit
    cubit = UserProfileCubit(getUserProfile: GetUserProfile(repository));
    serviceLocator.registerSingleton<UserProfileCubit>(cubit);
  });

  tearDown(() {
    // Clean up dependencies
    serviceLocator.reset();
  });

  group('App Integration Test', () {
    testWidgets(
      'User profile loads successfully',
      (tester) async {
        // Mock a successful user profile
        const testUser = User(id: 1, name: 'John Doe');
        when(() => repository.getUserById('1')).thenAnswer(
          (_) async => const Right(testUser),
        );

        // Launch the app
        app.main(runDependencies: false);
        await tester.pumpAndSettle(const Duration(milliseconds: 2000));

        // verify the app start with the UserProfileScreen
        expect(find.text('User Profile'), findsOneWidget);

        // Simulate waiting for the Cubit to load data
        await tester.pump();

        // Verify that the user profile is displayed
        expect(find.text('Hello, ${testUser.name}!'), findsOneWidget);
      },
    );
  });

  testWidgets(
    'User profile fails to load',
    (tester) async {
      // Mock a failure in user profile loading
      const errorMessage = 'Failed to load user profile';
      when(() => repository.getUserById('1')).thenAnswer(
        (_) async => const Left(
          Failure(errorMessage),
        ),
      );

      // Launch the app
      app.main(runDependencies: false);
      await tester.pumpAndSettle(const Duration(milliseconds: 2000));

      // Verify the app starts with the UserProfileScreen
      expect(find.text('User Profile'), findsOneWidget);

      // Simulate waiting for the Cubit to load data
      await tester.pump();

      // Verify that the error message is displayed
      expect(find.text(errorMessage), findsOneWidget);
    },
  );
}
