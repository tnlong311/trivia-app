class Question {
  final int id, clock;

  Question(
      {required this.id,
      required this.clock});


  factory Question.fromRTDB(Map data){
    return Question(
      id: data['qid'],
      clock: data['timer'],
    );
  }

}
