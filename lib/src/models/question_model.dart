class QuestionModel {
  final int faqId;
  final String question;
  final String answer;
  final DateTime creationTime;
  //final String creationTime;
  //final bool? favorite;

  const QuestionModel({
    required this.faqId,
    required this.question,
    required this.answer,
    required this.creationTime,
    //required this.creationTime,
    // this.favorite,
  });

  static QuestionModel fromJson(Map<String, dynamic> json) => QuestionModel(
        faqId: json['faqid'],
        question: json['question'],
        answer: json['answer'],
        creationTime: DateTime.parse(json['creationTime'] as String),
        //favorite: json['favorite'],
      );

  //for first time when get api and save to db then getAll to show.
  factory QuestionModel.fromJsonApi(Map<String, dynamic> json) => QuestionModel(
        faqId: json['faqid'],
        question: json['question'],
        answer: json['answer'],
        creationTime: DateTime.parse(json['creationTime'] as String),
      );

  Map<String, dynamic> toJson() => {
        "faqid": faqId,
        "question": question,
        "answer": answer,
        "creationTime": creationTime.toIso8601String(),
        //  "favorite": favorite,
      };
}
