import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mokpos/app/view/onboarding_screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

import 'app/view_model/auth_provider.dart';
import 'di/locator.dart';
import 'local_storage/local_db.dart';
import 'local_storage/theme_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await AppDependencies.register();
  await AppDataBaseService.startService();
  await ThemeDataBaseService.startService();

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setWholeAppState(BuildContext context) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setWholeAppState();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setWholeAppState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'MokPos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: Color(0xFF2A3256),
              fontSize: 16,
            ),
          ),
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
