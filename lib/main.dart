import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/onboarding_screen.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/firebase_options.dart';
import 'package:mokpos/util/providers/provider.dart';
import 'package:provider/provider.dart';

import 'app/view/main_screen.dart';
import 'di/locator.dart';
import 'local_storage/local_db.dart';
import 'local_storage/theme_db.dart';
import 'repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AppDependencies.register();
  await AppDataBaseService.startService();
  await ThemeDataBaseService.startService();

  runApp(await App.withDependency());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class App extends StatelessWidget {
  static Future<Widget> withDependency() async {
    final repo = await Repository.createInstance();
    return MultiProvider(
      providers: getProvidersWithNfc(repo),
      child: App(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MokPos',
      home: MyApp(),
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
      // darkTheme: _themeData(Brightness.dark),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildHome();
  }

  buildHome() {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return Builder(
          // stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context) {
            // print("Checking Snapshot data => ${snapshot}");
            if (FirebaseAuth.instance.currentUser != null) {
              print("User is not null");
              // print(snapshot);
              return FutureBuilder(
                future: userViewModel.getUser(),
                builder: (context, AsyncSnapshot dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return OnboardingScreen();
                  } else {
                    // return Builder(builder: (context) {
                    //   print(
                    //       "======UserType====> ${userViewModel.user?.userType}");

                    if (userViewModel.user?.userType == "owner") {
                      // Constant.navigatePushReplacement(context, MainScreen());
                      return MainScreen();
                    } else {
                      // Constant.navigatePushReplacement(context, CashierMainScreen());
                      return CashierMainScreen();
                    }
                    // });
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
