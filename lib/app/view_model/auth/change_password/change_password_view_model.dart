import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/error_dialog.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser = FirebaseAuth.instance.currentUser!;
  bool passwordCorrect = false;
  var authResult;

  // Check if password is correct
  Future<void> verifyOldPassword(String email, String oldPassword) async {
    var firebaseUser = _auth.currentUser!;

    var authCredentials = EmailAuthProvider.credential(
      email: firebaseUser.email!,
      password: oldPassword,
    );
    try {
      authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      print('====>>>> ${authResult.user}');
      passwordCorrect = authResult.user != null;
      print('PasswordCorrect ====> $passwordCorrect');
    } catch (e) {
      print(e);
      passwordCorrect = false;
      print('PasswordCorrect ====> $passwordCorrect');
    }
  }

  Future<void> updatePassword(String password) async {
    try {
      currentUser!.updatePassword(password).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  changePassword(
      BuildContext context, String password, String oldPassword) async {
    print('Verifying Old Password');
    await verifyOldPassword(currentUser.email!, oldPassword);
    print('=======> ${currentUser.email}');
    if (passwordCorrect) {
      print('Changing Password... Please wait');
      try {
        await updatePassword(password);
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              text: e.toString(),
            );
          },
        );
      }
      print('Password updated successfully');
    } else {
      print('Old password is incorrect. Did you forget your password?');
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            text:
                'Your old password is incorrect. Did you forget your password?',
            buttonLabel: 'Try Again',
          );
        },
      );
    }
    passwordCorrect = false;
    authResult = 0;
  }
}
