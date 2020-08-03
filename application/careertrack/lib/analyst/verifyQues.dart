import 'package:careertrack/models/analystDB.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  static const String id = 'verify_screen';

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  var _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analyst"),
      ),
      body: FutureBuilder(
        future: VerifyQues.fetchAll(-1),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var list = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          list[_counter].question,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          height: list[_counter].options.length * (50.0 + 20.0),
                            child: getRadios(list[_counter].options, list[_counter].rtAns),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        getButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("errorr");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget getRadios(options, ra) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (ctx, i) {
        return Container(
          height: 50.0,
          padding: EdgeInsets.only(left: 30.0),
          margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: options[i] != ra ? Colors.teal : Colors.orangeAccent,
          ),
          child: Row(
            children: <Widget>[
              options[i] == ra ? Container(
                margin: EdgeInsets.only(
                  right: 5.0,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ) : Container(),
              Text(
                "${i + 1}. ${options[i]}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
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
          color: Colors.red,
          disabledColor: Colors.grey,
          textColor: Colors.white,
          splashColor: Colors.teal,
          minWidth: 30.0,
          onPressed: () {
            _incrementCounter();
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.delete,
                size: 20.0,
              ),
              Text(
                "Delete",
              ),
            ],
          ),
        ),
        MaterialButton(
          color: Colors.green,
          disabledColor: Colors.grey,
          textColor: Colors.white,
          splashColor: Colors.teal,
          minWidth: 110.0,
          onPressed: () {
            _incrementCounter();
          },
          child: Row(
            children: <Widget>[

              Icon(
                Icons.verified_user,
                size: 20.0,
              ),
              Text(
                "Verify",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
