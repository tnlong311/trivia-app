class Question {
  final int id, clock;
  final String? additionInfo;

  Question(
      {required this.id,
      required this.clock,
      this.additionInfo});


  factory Question.fromRTDB(Map<String, dynamic> data){
    return Question(
      id: data['qid'],
      clock: data['timer'],
      additionInfo: data['fun fact'],
    );
  }

}
