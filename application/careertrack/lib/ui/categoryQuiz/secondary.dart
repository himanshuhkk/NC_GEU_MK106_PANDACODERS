import 'package:camera/camera.dart';
import 'package:careertrack/models/analystDB.dart';
import 'package:careertrack/models/faceResults.dart';
import 'package:careertrack/ui/pages/check_answers.dart';
import 'package:careertrack/ui/ytPlayer/Pdf.dart';
import 'package:flutter/material.dart';
import 'package:careertrack/models/category.dart';
//import 'package:careertrack/models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:careertrack/ui/pages/quiz_finished.dart';
import 'package:html_unescape/html_unescape.dart';

class Assessment extends StatefulWidget {
  final String category, title;

  const Assessment({Key key, @required this.title, this.category})
      : super(key: key);

  @override
  _AssessmentState createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);
  CameraController controller;

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
//    Question question = widget.questions[_currentIndex];
//    final List<dynamic> options = question.incorrectAnswers;
//    if (!options.contains(question.correctAnswer)) {
//      options.add(question.correctAnswer);
//      options.shuffle();
//    }

    return FutureBuilder(

      future: VerifyQues.fetchAssissment(30, widget.category),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              key: _key,
              appBar: AppBar(
                title: Text(widget.title),
                elevation: 0,
              ),
              body: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      decoration:
                      BoxDecoration(color: Theme.of(context).errorColor),
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Text("${_currentIndex + 1}"),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                HtmlUnescape().convert(
                                    snapshot.data[_currentIndex].question),
                                softWrap: true,
                                style: MediaQuery.of(context).size.width > 800
                                    ? _questionStyle.copyWith(fontSize: 30.0)
                                    : _questionStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ...snapshot.data[_currentIndex].options.map((option) => RadioListTile(

                                title: Text(HtmlUnescape().convert("$option"),style: MediaQuery.of(context).size.width > 800
                                    ? TextStyle(
                                    fontSize: 30.0
                                ) : null,),
                                groupValue: _answers[_currentIndex],
                                value: option,
                                onChanged: (value) {
                                  setState(() {
                                    _answers[_currentIndex] = option;
                                  });
                                },
                              )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              padding: MediaQuery.of(context).size.width > 800
                                  ? const EdgeInsets.symmetric(vertical: 20.0,horizontal: 64.0) : null,
                              child: Text(
                                _currentIndex == (snapshot.data.length - 1)
                                    ? "Submit"
                                    : "Next", style: MediaQuery.of(context).size.width > 800
                                  ? TextStyle(fontSize: 30.0) : null,),
                              onPressed: (){
                                _nextSubmit(snapshot);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if(snapshot.hasError) {
          return Center(
            child: Text(
              "An Error Occurred!"
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    },
    );
  }

  void _nextSubmit(snapshot) {
    if (_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Please select an answer to continue."),
      ));
      return;
    }
    if (_currentIndex < (snapshot.data.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => ResultPage(
              questions: snapshot.data, answers: _answers)));
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);

                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}


class ResultPage extends StatelessWidget {
  final List<VerifyQues> questions;
  final Map<int, dynamic> answers;
  final pdfs = Pdf.fetchAllPdfs();

  int correctAnswers;
  ResultPage({Key key, @required this.questions, @required this.answers}): super(key: key) {

  }

  @override
  Widget build(BuildContext context){
    int correct = 0;
    this.answers.forEach((index,value){
      if(this.questions[index].rtAns == value)
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
                          builder: (_) => ChkAnswer(questions: questions, answers: answers,)
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



class ChkAnswer extends StatelessWidget {
  final List<VerifyQues> questions;
  final Map<int,dynamic> answers;

  const ChkAnswer({Key key, @required this.questions, @required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Answers'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
              ),
              height: 200,
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: questions.length+1,
            itemBuilder: _buildItem,

          )
        ],
      ),
    );
  }
  Widget _buildItem(BuildContext context, int index) {
    if(index == questions.length) {
      return RaisedButton(
        child: Text("Done"),
        onPressed: (){
          Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
        },
      );
    }
    var question = questions[index];
    bool correct = question.rtAns == answers[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(HtmlUnescape().convert(question.question), style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.0
            ),),
            SizedBox(height: 5.0),
            Text(HtmlUnescape().convert("${answers[index]}"), style: TextStyle(
                color: correct ? Colors.green : Colors.red,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 5.0),
            correct ? Container(): Text.rich(TextSpan(
                children: [
                  TextSpan(text: "Answer: "),
                  TextSpan(text: HtmlUnescape().convert(question.rtAns) , style: TextStyle(
                      fontWeight: FontWeight.w500
                  ))
                ]
            ),style: TextStyle(
                fontSize: 16.0
            ),)
          ],
        ),
      ),
    );
  }
}