import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../../services/auth_service.dart';
import '../../user/user_view_model.dart';

class RegisterViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String username = "", email = "", phone = "", password = "", cPassword = "";
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode countryFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  AuthService auth = AuthService();

  register(BuildContext context) async {
    print(email);
    print(password);
    print(cPassword);
    print(phone);
    FormState form = formKey.currentState!;
    // form.save();
    // if (!form.validate()) {
    //   validate = true;
    //   notifyListeners();
    //   showInSnackBar(
    //       context, 'Please fix the errors in red before submitting.');
    // } else {
    //   if (password == cPassword) {
    loading = true;
    notifyListeners();
    try {
      bool success = await auth.createUser(
        name: username,
        email: email,
        password: password,
        phone: phone,
      );
      print(success);

      //if there are no erros on the sign
      //go to upload profile picture screen
      if (success) {
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (_) => MainScreen()));
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e);
      showInSnackBar(context, '${auth.handleFirebaseAuthError(e.toString())}');
    }
    loading = false;
    notifyListeners();
    // } else {
    //   showInSnackBar(context, 'The passwords does not match');
    // }
    // }
    Provider.of<UserViewModel>(context, listen: false).getUser();
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  setName(val) {
    username = val;
    notifyListeners();
  }

  setConfirmPass(val) {
    cPassword = val;
    notifyListeners();
  }

  setPhone(val) {
    phone = val;
    notifyListeners();
  }

  void showInSnackBar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
