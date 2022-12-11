import 'package:auto_route/auto_route.dart';

import '../../main.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    //* Main/Root Page
    AutoRoute(page: MainPage, initial: true),
  ],
)
class $AppRouter {}

void routeMenu() {}
