import 'package:flutter/material.dart';
import 'package:silent_moon/features/meditation/presentation/pages/meditate_screen.dart';
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
  static const String musicV2 =
      '/music-v2'; // deprecated route if causing conflicts
  static const String playOption = '/play-option';
  static const String reminders = '/reminders';
  static const String userProfile = '/user-profile';
  static const String meditate = '/meditate-screen';
}

/// App route generator
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.courseDetail:
        return MaterialPageRoute(
          builder: (_) => const CourseDetailScreen(session: sessionin),
        );
      case AppRoutes.music:
        return MaterialPageRoute(builder: (_) => const MusicScreen());
      case AppRoutes.playOption:
        return MaterialPageRoute(builder: (_) => const PlayOptionScreen());
      case AppRoutes.reminders:
        return MaterialPageRoute(builder: (_) => const RemindersPage());
      case AppRoutes.userProfile:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case AppRoutes.meditate:
        return MaterialPageRoute(builder: (_) => const MeditateScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SignInSignUpScreen());
    }
  }
}
