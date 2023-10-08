import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mokpos/app/model/user_model.dart';
import 'package:mokpos/util/firebase/firebase.dart';

class UserViewModel extends ChangeNotifier {
  // User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? user;

  // setUser() {
  //   user = auth.currentUser;
  //   notifyListeners();
  // }

  Future<void> getUser() async {
    DocumentSnapshot<Object?> doc =
        await usersRef.doc(auth.currentUser!.uid).get();

    if (doc.exists) {
      var tempUser = doc.data() as Map<String, dynamic>;
      print("TempUser => $tempUser");

      user = UserModel.fromJson(tempUser);
    } else {
      print("User doesn't exist");
    }
  }
}
