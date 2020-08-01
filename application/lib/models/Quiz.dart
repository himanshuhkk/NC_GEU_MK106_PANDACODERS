class Question {
  final int id;
  final String question;
  final List<String> options;
  static double time = 120.0; // seconds

  Question(this.id, this.question, this.options);

  static List<Question> fetchAll() {
    return List<Question>.generate(10, (i) {
      return Question(
        i + 1,
        "This is question ${i + 1} here.",
        [
          "Option A${i + 1}",
          "Option B${i + 1}",
          "Option C${i + 1}",
          "Option D${i + 1}"
        ],
      );
    });
  }

  static Question fetchByID(int id) {
    List<Question> qs = Question.fetchAll();
    for (var i = 0; i < qs.length; i++) {
      if (qs[i].id == id) {
        return qs[i];
      }
    }
    return null;
  }

  static bool hasNext(int id) {
    return id < Question.fetchAll().length - 1;
  }
}
