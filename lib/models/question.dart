class Question {
  final int id, clock;
  final String type, correct, fullCorrect;
  final String? additionInfo;

  Question(
      {required this.id,
      required this.clock,
      required this.type,
      required this.correct,
      required this.fullCorrect,
      this.additionInfo});

  factory Question.fromRTDB(Map<String, dynamic> data){
    return Question(
      id: data['qid'],
      type: data['answer type'],
      clock: data['timer'],
      correct: data['correct'],
      fullCorrect: data['full correct'],
      additionInfo: data['fun fact'],
    );
  }

}
