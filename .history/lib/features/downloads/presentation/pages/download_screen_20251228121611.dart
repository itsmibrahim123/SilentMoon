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

    // --- FIX 1: COURSE DETAIL ---
    case AppRoutes.courseDetail:
      // Retrieve the Session object passed as arguments
      if (settings.arguments is Session) {
        final session = settings.arguments as Session;
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(session: session),
        );
      }
      return _errorRoute(); // Fallback if argument is missing

    case AppRoutes.music:
      return MaterialPageRoute(builder: (_) => const MusicScreen());

    // --- FIX 2: PLAY OPTION ---
    case AppRoutes.playOption:
      // Retrieve the Track object passed as arguments
      // Note: Make sure to import your Track entity!
      if (settings.arguments is Track) {
        final track = settings.arguments as Track;
        return MaterialPageRoute(
          builder: (_) => PlayOptionScreen(track: track),
        );
      }
      return _errorRoute();

    case AppRoutes.reminders:
      return MaterialPageRoute(builder: (_) => const RemindersPage());
    case AppRoutes.userProfile:
      return MaterialPageRoute(builder: (_) => const UserProfileScreen());
    case AppRoutes.meditate:
      return MaterialPageRoute(builder: (_) => const MeditateScreen());
      
    default:
      return _errorRoute();
  }
}

// Add a simple error route helper
static Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: const Center(child: Text("Page not found or missing arguments")),
    ),
  );
}