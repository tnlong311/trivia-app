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
    index--;

    return index;
  }

  static getUserScore(String id) async {
    final snapshot = await gameRef
        .child('scores/$id/score')
        .get()
        .catchError((error) => print(error));

    return snapshot.value ?? 1024;
  }

  static Future<void> postTotalScore(String id, int score) async {
    await gameRef
        .child('scores/$id/score')
        .set(score)
        .then((value) => print('updated $score to $id'))
        .catchError((error) => print(error));
  }

  static Future<void> postScoreChange(
      String id, int question, int score) async {
    await gameRef
        .child('scores/$id/changes')
        .update({'$question': score})
        .then((value) => print('updated $score to $question on user $id'))
        .catchError((error) => print(error));
  }
}
