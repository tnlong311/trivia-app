import 'package:firebase_auth/firebase_auth.dart';

import '../consts/user_const.dart';

class AuthService {
  static bool isSignedIn() {
    var currentUser = FirebaseAuth.instance.currentUser;
    // print(currentUser);
    return currentUser != null;
  }

  static getPin() {
    return emailToPin(FirebaseAuth.instance.currentUser?.email);
  }

  static testSignIn() async {
    // String testPin = '745070';
    String testPin = '31120';

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: testPin + EMAIL_TAIL, password: DEFAULT_PASSWORD)
        .then((_) => print('signed in as test account'))
        .catchError((error) => print(error));

    return null;
  }

  static signIn(String pin) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: pin + EMAIL_TAIL, password: DEFAULT_PASSWORD);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }

    var currentUser = FirebaseAuth.instance.currentUser;

    return emailToPin(currentUser?.email);
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();

    return null;
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
