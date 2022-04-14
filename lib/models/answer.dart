class Answer {
  final int id;
  final String type, correct, fullCorrect;

  Answer(
      {required this.id,
      required this.type,
      required this.correct,
      required this.fullCorrect});

  factory Answer.fromRTDB(Map data) {
    return Answer(
      id: data['qid'],
      type: data['answer type'].toString(),
      correct: data['correct'].toString(),
      fullCorrect: data['full correct'].toString(),
    );
  }
}
