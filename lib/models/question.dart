class Question {
  final String question;
  final Map<String, String> answers;
  final String correctAnswer;

  Question(
      {required this.question,
      required this.answers,
      required this.correctAnswer});
}
