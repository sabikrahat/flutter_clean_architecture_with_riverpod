class AppRoutes {
  ///
  /// isMaintenanceBreak is a global variable that is set to true when the app
  static const isMaintenanceBreak = false;

  ///
  static const String homeRoute = '/';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String settingsRoute = '/settings';
  static const String maintenanceBreakRoute = '/maintenance-break';
  static const String productRoute = '/product';

  static const List<String> allRoutes = [
    homeRoute,
    signinRoute,
    signupRoute,
    settingsRoute,
    productRoute,
  ];

  static final List<String> allAuthRequiredRoutes = [...allRoutes]
    ..remove(signinRoute)
    ..remove(signupRoute);

  static final List<String> authRelatedRoutes = [
    signinRoute,
    signupRoute,
  ];
}
