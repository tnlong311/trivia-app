import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static bool isSignedIn() {
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    return currentUser != null;
  }

  static testSignIn() async {
    print('here');

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: '31120@trivia.com', password: 'triviaiscool')
        .then((_) => print('signed in as test account'))
        .catchError((error) => print(error));
    print('here');

    return null;
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();

    return null;
  }
}
