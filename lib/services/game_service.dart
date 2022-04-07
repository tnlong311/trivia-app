import 'package:firebase_database/firebase_database.dart';

class RtdbGameService {
  static DatabaseReference gameRef =
      FirebaseDatabase.instance.ref().child('/gameplay/2022');

  static getCurrentQuestion() async {
    final snapshot = await gameRef
        .child('game status/current')
        .get()
        .catchError((error) => print(error));

    return snapshot.value ?? 0;
  }

  static getCurrentIndex() async {
    var index = await getCurrentQuestion();
    index --;

    return index;
  }
}
