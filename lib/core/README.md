# Core Module

The core module contains shared functionality used across all features.

## Structure

```
core/
├── constants/          # App-wide constants
│   ├── app_colors.dart
│   ├── app_strings.dart
│   ├── app_assets.dart
│   └── app_dimensions.dart
├── errors/            # Error handling
│   ├── failures.dart
│   └── exceptions.dart
├── injection/         # Dependency injection
│   └── injection_container.dart
└── utils/            # Utility functions
    └── size_utils.dart
```

## Usage

### Constants
```dart
import 'package:silent_moon/core/constants/app_colors.dart';
import 'package:silent_moon/core/constants/app_strings.dart';
import 'package:silent_moon/core/constants/app_assets.dart';

Container(color: AppColors.primaryPurple)
Text(AppStrings.welcomeBack)
Image.asset(AppAssets.logo)
```

### Errors
```dart
import 'package:silent_moon/core/errors/failures.dart';

Either<Failure, User> result = await repository.signIn(...);
result.fold(
  (failure) => print(failure.message),
  (user) => print(user.name),
);
```

### Dependency Injection
```dart
import 'package:silent_moon/core/injection/injection_container.dart';

// Register dependencies
sl.registerLazySingleton(() => AuthRepositoryImpl());

// Get dependencies
final repository = sl<AuthRepository>();
```

### Utils
```dart
import 'package:silent_moon/core/utils/size_utils.dart';

double width = context.w(100);
double height = context.h(200);
double fontSize = context.fs(16);
```
