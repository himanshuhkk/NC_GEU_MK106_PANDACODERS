import 'dart:async';

import 'package:careertrack/btmBar.dart';
import 'package:careertrack/models/Quiz.dart';
import 'package:careertrack/ui/quiz/resultScreen.dart';
import 'package:flutter/material.dart';

class QuizHome1 extends StatefulWidget {
  static const String id = 'quiz_screen';

  @override
  _QuizHome1State createState() => _QuizHome1State();
}

class _QuizHome1State extends State<QuizHome1> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  int _counter = 0;
  static List<Question> list = Question.fetchAll();
  var _selected = List<String>(list.length);
  var _currentTime = "00:00", totalTime = Question.time;
  Timer myTimer;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _animationController.forward();
    myTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      var arr = _currentTime.split(":");
      var mins = int.parse(arr[0]);
      var secs = int.parse(arr[1]);
      if (mins * 60 + secs > totalTime - 1) {
        //todo: time's up!!! submit
        myTimer.cancel();
        return;
      }
      if (secs >= 59) {
        mins++;
        secs = 0;
      } else {
        secs++;
      }
      var time =
          "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
      setState(() {
        _currentTime = time;
      });
      ;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeCounter(i) {
    setState(() {
      _counter += i;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.orangeAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.format_list_numbered,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "${_counter + 1}/${list.length}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.alarm,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      _currentTime,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    opacity: 1 - _animation.value,
                    child: Text(
                      list[_counter].question,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                      height: list[_counter].options.length * (50.0 + 20.0),
                      child: getRadios()),
                  SizedBox(
                    height: 40.0,
                  ),
                  getButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRadios() {
    return ListView.builder(
      itemCount: list[_counter].options.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selected[_counter] = list[_counter].options[i];
            });
          },
          child: Transform.translate(
            offset: Offset(_animation.value * 20, 0.0),
            child: Opacity(
              opacity: 1 - _animation.value,
              child: AnimatedContainer(
                height: 50.0,
                padding: EdgeInsets.only(left: 30.0),
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: _selected[_counter] == list[_counter].options[i]
                      ? Colors.orangeAccent
                      : Colors.teal,
                ),
                duration: Duration(milliseconds: 200),
                child: Row(
                  children: <Widget>[
//                    Radio(
//                      activeColor: Colors.orangeAccent,
//                      value: list[_counter].options[i],
//                      groupValue: _selected[_counter],
//                      onChanged: (Object value) {
//                        setState(() {
//                          _selected[_counter] = value;
//                        });
//                      },
//                    ),
                    Text(
                      "${i + 1}. ${list[_counter].options[i]}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        MaterialButton(
          color: Colors.orangeAccent,
          disabledColor: Colors.grey,
          textColor: Colors.white,
          splashColor: Colors.teal,
          minWidth: 30.0,
          onPressed: _counter == 0
              ? null
              : () {
                  _changeCounter(-1);
                },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_back,
                size: 20.0,
              ),
              Text(
                "Previous",
              ),
            ],
          ),
        ),
        Question.hasNext(_counter)
            ? MaterialButton(
                color: Colors.orangeAccent,
                disabledColor: Colors.grey,
                textColor: Colors.white,
                splashColor: Colors.teal,
                minWidth: 110.0,
                onPressed: () {
                  _changeCounter(1);
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      "Next",
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 20.0,
                    ),
                  ],
                ),
              )
            : MaterialButton(
                color: Colors.teal,
                textColor: Colors.white,
                splashColor: Colors.orangeAccent,
                minWidth: 110.0,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(),
                    ),
                  );
                  myTimer.cancel();
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.save,
                      size: 20.0,
                    ),
                    Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
