import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_storage/local_db.dart';
import '../local_storage/theme_db.dart';

final GetIt locator = GetIt.instance;

class AppDependencies {
  static Future<void> reset() async {
    await locator.reset();
    await register();
  }

  static Future<void> register() async {
    _registerBaseDependencies();
    // _registerAuthenticationDependencies();
    // _registerNDADependencies();
    await locator.isReady<SharedPreferences>();
    await locator.allReady();
  }

  ///
  ///
  /// BASE DEPENDENCIES
  ///
  ///
  static _registerBaseDependencies() {
    locator.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    locator.registerLazySingleton<AppDataBaseService>(
      () => AppDataBaseService(),
    );
    locator.registerLazySingleton<ThemeDataBaseService>(
      () => ThemeDataBaseService(),
    );
  }
}
