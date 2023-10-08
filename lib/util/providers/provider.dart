import 'package:mokpos/app/view_model/auth/sign_up/register_view_model.dart';
import 'package:mokpos/app/view_model/auth_provider.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../app/view_model/auth/change_password/change_password_view_model.dart';
import '../../app/view_model/auth/login/login_view_model.dart';
import '../../app/view_model/auth/shop/shop_view_model.dart';
import '../../app/view_model/user/user_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  // ChangeNotifierProvider(create: (_) => ProfileViewModel()),
  ChangeNotifierProvider(create: (_) => UserViewModel()),
  // ChangeNotifierProvider(create: (_) => SearchViewModel()),
  // ChangeNotifierProvider(create: (_) => CreatePostViewModel()),
  // ChangeNotifierProvider(create: (_) => EditPersonalInfoViewModel()),
  // ChangeNotifierProvider(create: (_) => ChangeDPProvider()),
  ChangeNotifierProvider(create: (_) => ChangePasswordViewModel()),
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => ShopViewModel()),
  ChangeNotifierProvider(create: (_) => CustomerViewModel()),
];
