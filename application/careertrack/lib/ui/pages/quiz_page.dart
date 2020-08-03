import 'package:camera/camera.dart';
import 'package:careertrack/models/faceResults.dart';
import 'package:flutter/material.dart';
import 'package:careertrack/models/category.dart';
import 'package:careertrack/models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:careertrack/ui/pages/quiz_finished.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;

  const QuizPage({Key key, @required this.questions, this.category})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);
  CameraController controller;
  var ImagePath;
  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadCamera();

    Future.delayed(const Duration(seconds: 5), () {
      onCaptureButtonPressed();
    });
  }

  void _loadCamera() async {
    List<CameraDescription> cameras = await availableCameras();

    controller = CameraController(cameras[1], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }
    return WillPopScope(
      onWillPop: () {
        _onWillPop(context);
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.category.name),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).errorColor),
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
                              widget.questions[_currentIndex].question),
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
                        ...options.map((option) => RadioListTile(
                              title: Text(
                                HtmlUnescape().convert("$option"),
                                style: MediaQuery.of(context).size.width > 800
                                    ? TextStyle(fontSize: 30.0)
                                    : null,
                              ),
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
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          _nextSubmit(context);
                        },
                        child: Container(
                          height: 60.0,
                          width: 100.0,
                          margin: EdgeInsets.only(
                            right: 20.0,
                            bottom: 20.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child:
                                _currentIndex == (widget.questions.length - 1)
                                    ? Text(
                                        "Submit",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "Next",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.navigate_next,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180.0,
                  width: 150.0,
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
              left: 0,
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }

  void _nextSubmit(BuildContext context) {
    if (_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Please select an answer to continue."),
      ));
      return;
    }
    if (_currentIndex < (widget.questions.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QuizFinishedPage(
              questions: widget.questions, answers: _answers)));
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
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
      },
    );
  }

  void onCaptureButtonPressed() async {
    //on camera button press
    try {
      final path = join(
        (await getTemporaryDirectory()).path, //Temporary path
        '${DateTime.now()}.png',
      );
      ImagePath = path;
      await controller.takePicture(path);

      FaceResults.fetchFaceResults(path).then((value) {
        print("mmn");
        print(value);
        if (value == "multiple faces") {
          _showModal();
        }
      }); //take photo
    } catch (e) {}
  }

  _showModal() {
    Get.dialog(SimpleDialog());
  }
}
