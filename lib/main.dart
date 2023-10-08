import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/auth_screens/choose_login.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_home_screen.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/onboarding_screen.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/firebase_options.dart';
import 'package:mokpos/util/providers/provider.dart';
import 'package:provider/provider.dart';

import 'app/view/main_screen.dart';
import 'app/view_model/auth_provider.dart';
import 'di/locator.dart';
import 'local_storage/local_db.dart';
import 'local_storage/theme_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      providers: providers,
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
        home: buildHome(),
      ),
    );
  }

  buildHome() {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            print("Checking Snapshot data => ${snapshot}");
            if (snapshot.hasData) {
              print("Snapshot has data");
              print(snapshot);
              return FutureBuilder(
                future: userViewModel.getUser(),
                builder: (context, AsyncSnapshot dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return OnboardingScreen();
                  } else {
                    return Builder(builder: (context) {
                      print(
                          "======UserType====> ${userViewModel.user?.userType}");

                      if (userViewModel.user?.userType == "owner") {
                        // Constant.navigatePushReplacement(context, MainScreen());
                        return MainScreen();
                      } else {
                        // Constant.navigatePushReplacement(context, CashierMainScreen());
                        return CashierMainScreen();
                      }
                    });
                  }
                },
              );
            } else {
              return OnboardingScreen();
            }
          },
        );
      },
    );
  }
}
