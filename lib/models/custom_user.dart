import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import '../consts/user_const.dart';

class CustomUser {
  final String pin;
  final String? name;
  final String role;

  CustomUser({required this.pin, this.name, required this.role});

  static final DatabaseReference ref = FirebaseDatabase.instance.ref();
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static createCustomUser() async {
    DatabaseReference userRef = ref.child('/users');
    final String pin = (Random().nextInt(900000) + 100000).toString();
    // final String pin = '31120';
    final String accountName = pin + EMAIL_TAIL;

    // final res = auth.signInWithEmailAndPassword(
    //     email: accountName, password: DEFAULT_PASSWORD);
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: accountName, password: DEFAULT_PASSWORD);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists.');
      }
    } catch (e) {
      print(e);
    }

    await userRef
        .child(pin)
        .update({
      'pin': pin,
      'role': 'user',
    })
        .then((_) => print('User updated to RTDB'))
        .catchError((error) => print(error));

    await ref
        .child('gameplay/2022/scores')
        .update({
      pin: {
        'score': DEFAULT_SCORE,
      }
    })
        .then((_) => print('User added to gameplay'))
        .catchError((error) => print(error));

    print('User created');
  }

  static getPinList() async {
    DatabaseReference userRef = ref.child('/users');

    await userRef.get().then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        (snapshot.value as Map).forEach((key, value){
          print(key);
        });
      }
    }).catchError((error) => print(error));
  }
}
