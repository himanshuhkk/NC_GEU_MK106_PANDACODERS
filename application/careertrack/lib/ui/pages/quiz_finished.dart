import 'package:careertrack/ui/ytPlayer/Pdf.dart';
import 'package:flutter/material.dart';
import 'package:careertrack/models/question.dart';
import 'package:careertrack/ui/pages/check_answers.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizFinishedPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final pdfs = Pdf.fetchAllPdfs();

  int correctAnswers;
  QuizFinishedPage({Key key, @required this.questions, @required this.answers}): super(key: key) {
    
  }

  @override
  Widget build(BuildContext context){
    int correct = 0;
    this.answers.forEach((index,value){
      if(this.questions[index].correctAnswer == value)
        correct++;
    });
    final TextStyle titleStyle = TextStyle(
      color: Colors.black87,
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );
    final TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Total Questions", style: titleStyle),
                  trailing: Text("${questions.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Score", style: titleStyle),
                  trailing: Text("${correct/questions.length * 100}%", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Correct Answers", style: titleStyle),
                  trailing: Text("$correct/${questions.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Incorrect Answers", style: titleStyle),
                  trailing: Text("${questions.length - correct}/${questions.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Theme.of(context).accentColor.withOpacity(0.8),
                    child: Text("Goto Home"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Text("Check Answers"),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CheckAnswersPage(questions: questions, answers: answers,)
                      ));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: Text(
                    "You are quite responsive while answering, kindly be joyful and relax while the quiz. We are here t help you positively if you honestly answer the questions."
                ),
              ),
              SizedBox(height: 20,),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Recommended Courses',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 200.0,
                margin: EdgeInsets.only(
                  bottom: 50.0,
                ),
                child: ListView.builder(
                  itemCount: pdfs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ctxt, int i) {
                    return GestureDetector(
                      onTap: () {
//                        prepareTestPdf(pdfs[i].path).then((path) {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => FullPdfViewerScreen(path)),
//                          );
//                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        color: Colors.teal,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 150.0,
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Image.asset(
                                pdfs[i].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 1.5 - 20.0,
                              child: Center(
                                child: Text(
                                  pdfs[i].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}