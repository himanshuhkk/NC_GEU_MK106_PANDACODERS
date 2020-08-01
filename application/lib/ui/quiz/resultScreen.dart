import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 30.0,
            ),
            child: Text(
              "Result",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: _getResult(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error!",
                    ),
                  );
                } else if (snapshot.hasData) {
                  Map<String, dynamic> data = Map.from(snapshot.data);
                  return _getWidget(data, context);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _getResult() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    var data = {
      "detailed": {
        "Analytical Ability": 20.0,
        "Decision Making": 30.0,
        "Logical & Abstract Reasoning": 50.0,
        "Critical Thinking Ability": 70.0,
        "Problem Solving Ability": 10.0
      },
      "overall": 80.0
    };
    return data;
  }

  Widget _getWidget(Map<String, dynamic> data, BuildContext context) {
    var keys = data["detailed"].keys.toList();
    var vals = data["detailed"].values.toList();
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: 30.0,
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.orangeAccent,
              height: 80.0,
              margin: EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 20.0,
              ),
              child: AbsorbPointer(
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          height: 20.0,
                          child: Text(
                            "Overall",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: LinearProgressIndicator(
                            value: data["overall"] / 100.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 20.0,
                          child: Text(
                            "${data["overall"]}%",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Stack(
              children: <Widget>[
                Divider(
                  color: Colors.teal,
                  thickness: 2.0,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    color: Colors.white,
                    child: Text(
                        "Detailed Description",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            AbsorbPointer(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: keys.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    color: Colors.orangeAccent,
                    height: 80.0,
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Container(
                      height: 30.0,
                      padding: EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            height: 20.0,
                            child: Text(
                              "${keys[i]}",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: LinearProgressIndicator(
                              value: vals[i] / 100.0,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5.0,
                            ),
                            height: 20.0,
                            child: Text(
                              "${vals[i]}%",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Stack(
              children: <Widget>[
                Divider(
                  color: Colors.teal,
                  thickness: 2.0,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    color: Colors.white,
                    child: Text(
                        "Recommended Courses",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 150.0,
              margin: EdgeInsets.only(
                bottom: 50.0,
              ),
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    color: Colors.teal,
                    height: 100.0,
                    width: MediaQuery.of(context).size.width/1.5,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
