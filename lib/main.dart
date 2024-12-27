import 'package:flutter/material.dart';

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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
        builder: (context, child) {
          return AuthLayout(child: child!);
        },
        theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor:
                WidgetStateProperty.all(Colors.white.withValues(alpha: 0.3)),
          ),
        ));
  }
}
