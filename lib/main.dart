import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/services/navigation_services.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';

import 'package:admin_dashboard/router/router.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Dashboard',
        initialRoute: Flurorouter.rootRoute,
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        builder: (context, child) {
          final authProvider = Provider.of<AuthProvider>(context);

          if (authProvider.authStatus == AuthStatus.checking) {
            return SplashLayout();
          }

          if (authProvider.authStatus == AuthStatus.authenticated) {
            return DashboardLayout(child: child!);
          } else {
            return AuthLayout(child: child!);
          }
        },
        theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor:
                WidgetStateProperty.all(Colors.white.withValues(alpha: 0.3)),
          ),
        ));
  }
}
