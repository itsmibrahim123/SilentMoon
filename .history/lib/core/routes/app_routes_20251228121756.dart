import 'package:flutter/material.dart';

// --- Screen Imports ---
import '../../features/authentication/presentation/pages/sign_in_sign_up_screen.dart';
import '../../features/authentication/presentation/pages/sign_in_screen.dart';
import '../../features/authentication/presentation/pages/sign_up_screen.dart';
import '../../features/welcome/presentation/pages/welcome_screen.dart';
import '../../features/welcome/presentation/pages/welcome_sleep_screen.dart';
import '../../features/meditation/presentation/pages/choose_topic_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/meditation/presentation/pages/course_detail_screen.dart';
import '../../features/music/presentation/pages/music_screen.dart';
import '../../features/music/presentation/pages/play_option_screen.dart';
import '../../features/reminders/presentation/pages/reminders_page.dart';
import '../../features/profile/presentation/pages/user_profile_screen.dart';
import '../../features/meditation/presentation/pages/meditate_screen.dart';

// --- Entity Imports (CRITICAL: Needed for arguments) ---
import '../../features/home/domain/entities/session.dart';
import '../../features/sleep/domain/entities/track.dart';

/// App route names
class AppRoutes {
  AppRoutes._();

  static const String signInSignUp = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String welcome = '/welcome';
  static const String welcomeSleep = '/welcome-sleep';
  static const String chooseTopic = '/choose-topic';
  static const String home = '/home';
  static const String courseDetail = '/course-detail';
  static const String music = '/music';
  static const String playOption = '/play-option';
  static const String reminders = '/reminders';
  static const String userProfile = '/user-profile';
  static const String meditate = '/meditate-screen';
}

/// App route generator
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // --- Auth & Onboarding ---
      case AppRoutes.signInSignUp:
        return MaterialPageRoute(builder: (_) => const SignInSignUpScreen());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutes.welcomeSleep:
        return MaterialPageRoute(builder: (_) => const WelcomeSleepScreen());
      case AppRoutes.chooseTopic:
        return MaterialPageRoute(builder: (_) => const ChooseTopicScreen());

      // --- Main Tabs ---
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.meditate:
        return MaterialPageRoute(builder: (_) => const MeditateScreen());

      case AppRoutes.music:
        return MaterialPageRoute(builder: (_) => const MusicScreen());

      // --- Feature: Reminders ---
      case AppRoutes.reminders:
        return MaterialPageRoute(builder: (_) => const RemindersPage());

      // --- Feature: Profile ---
      case AppRoutes.userProfile:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());

      // --- Detail Screens (With Arguments) ---

      // 1. Course Detail (Requires Session Object)
      case AppRoutes.courseDetail:
        if (settings.arguments is Session) {
          final session = settings.arguments as Session;
          return MaterialPageRoute(
            builder: (_) => CourseDetailScreen(session: session),
          );
        }
        return _errorRoute('Missing or Invalid Session Argument');

      // 2. Play Option (Requires Track Object)
      case AppRoutes.playOption:
        if (settings.arguments is Track) {
          final track = settings.arguments as Track;
          return MaterialPageRoute(
            builder: (_) => PlayOptionScreen(track: track),
          );
        }
        return _errorRoute('Missing or Invalid Track Argument');

      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  // Error Page Helper
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Navigation Error")),
        body: Center(child: Text(message)),
      ),
    );
  }
}
