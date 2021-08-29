import 'package:auto_route/auto_route.dart';

import 'package:journaling_app/src/screens/Profile.dart';
import 'package:journaling_app/src/screens/calendar.dart';
import 'package:journaling_app/src/screens/create.dart';
import 'package:journaling_app/src/screens/home.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: CreateScreen),
    AutoRoute(page: CalendarScreen),
    AutoRoute(page: ProfileScreen),
  ],
)
class $AppRouter {}
