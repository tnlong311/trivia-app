import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../consts/user_const.dart';

class RtdbUserService {
  static DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('/users');

  static getCurrentUserPin() async {
    var currentUser = FirebaseAuth.instance.currentUser;

    return emailToPin(currentUser?.email);
  }

  static isNamed(String pin) async {
    bool exists = false;
    await userRef.child(pin).child('/name').get().then((DataSnapshot snapshot) {
      exists = snapshot.exists;
    });

    return exists;
  }

  static setName(String pin, String name) async {
    await userRef
        .child(pin)
        .child('/name')
        .set(name)
        .catchError((error) => print(error));
  }

  static String emailToPin(var str) {
    if (str == null) {
      return '';
    } else if (str.length < EMAIL_TAIL.length) {
      return str;
    } else {
      return str.substring(0, str.length - EMAIL_TAIL.length);
    }
  }
}
