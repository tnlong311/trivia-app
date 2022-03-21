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
}
