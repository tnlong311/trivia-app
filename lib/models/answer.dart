class Answer {
  final int id;
  final String type, correct, fullCorrect;

  Answer(
      {required this.id,
      required this.type,
      required this.correct,
      required this.fullCorrect});

  factory Answer.fromRTDB(Map<String, dynamic> data) {
    return Answer(
      id: data['qid'],
      type: data['answer type'],
      correct: data['correct'],
      fullCorrect: data['full correct'],
    );
  }
}
