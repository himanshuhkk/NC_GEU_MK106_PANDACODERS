import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class VerifyQues {
  final int id;
  final String question;
  final String rtAns;
  final String category;
  final List<String> options;
  static double time = 120.0; // seconds

  VerifyQues(this.id, this.question, this.options, this.rtAns, this.category);

  static Future<List<VerifyQues>> fetchAll(length) async{
    var dataset ;
    await FirebaseDatabase.instance
        .reference()
        .child('quiz')
        .child('srSec')
        .child('pcb')
        .once()
        .then((value) => dataset = value.value);

    var total = dataset.length;

    if(length == -1) {
      length = total;
    }

    var randomArr = List.generate(total, (index) => index)..shuffle();
    var randomQues = randomArr.take(length).toList();

    var list = List<VerifyQues>.generate(length, (i) {
      var ques = dataset[randomQues[i]];
      return VerifyQues(
          randomQues[i] + 1,
          ques["QUESTION"],
          [
            ques["OPTION1"],
            ques["OPTION2"],
            ques["OPTION3"],
            ques["OPTION4"],
          ],
          ques["ANSWER"],
        ques["NAME OF SUBJECT IN PARTICULAR STREAM"]);
    });

    return list;
  }
}
