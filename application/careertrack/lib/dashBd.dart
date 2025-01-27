import 'dart:io';
import 'dart:typed_data';

import 'package:careertrack/games/puzzle/puzzleHome.dart';
import 'package:careertrack/ui/categoryQuiz/secondary.dart';
import 'package:careertrack/ui/widgets/quiz_options.dart';
import 'package:careertrack/ui/ytPlayer/Pdf.dart';
import 'package:careertrack/ui/ytPlayer/yt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

import 'analyst/analystHome.dart';
import 'games/hangman/hangMan.dart';
import 'models/YtVideo.dart';
import 'models/category.dart';
import 'models/profileData.dart';

class MyDashBoard extends StatefulWidget {
  static const String id = 'HomeId';

  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  final pdfs = Pdf.fetchAllPdfs();
  final videos = YtVideo.fetchAllVideos();
  String titleVerify= "";

  @override
  void initState() {
    super.initState();
    ProfileData.fetchProfile().then((value) {
      setState(() {
        titleVerify = value.title;
      });
    });
  }

  _catPressed(BuildContext context, Category category) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(
          category: category,
        ),
        onClosing: () {},
      ),
    );
  }

  Widget _payOpns(quizName, imgSrc) {
    return Column(children: <Widget>[
      Container(
        height: 90,
        width: 90,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(imgSrc),
        ),
      ),
      Text(quizName),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if(titleVerify == "Kids"){
      return Scaffold(
        appBar: AppBar(
          title: Text("Career Succours"),
//          actions: <Widget>[
//            GestureDetector(
//              onTap: (){
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) {
//                      return AnalystScreen();
//                    }));
//              },
//              child: Icon(
//                Icons.add_box,
//              ),
//            ),
//            SizedBox(
//              width: 20.0,
//            ),
//            GestureDetector(
//              onTap: (){
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) {
//                      return PuzzleGame();
//                    }));
//              },
//              child: Icon(
//                Icons.games,
//              ),
//            ),
//            SizedBox(
//              width: 20.0,
//            ),
//            GestureDetector(
//              onTap: (){
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) {
//                      return HangMan();
//                    }));
//              },
//              child: Icon(
//                Icons.games,
//              ),
//            ),
//            SizedBox(
//              width: 20.0,
//            ),
//          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Psychological Tests',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            _catPressed(
                                context,
                                Category(9, "General Knowledge",
                                    icon: FontAwesomeIcons.globeAsia));
                          },
                          child: _payOpns("Behavioural",
                              'https://www.funds-europe.com/sites/default/files/images/stories/fe/supplements/FundTech_Spring_2019/Brain.jpg')),
//                      InkWell(
//                          onTap: () {
//                            if(titleVerify == "9th-10th"){
//
//                            }else if(titleVerify == "11th-12th"){
//                              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                return Assessment(title: titleVerify, category: "pcb");
//                              }));
//                            }else if(titleVerify == "College Student"){
//                              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                return Assessment(title: titleVerify, category: "grad");
//                              }));
//                            }else if(titleVerify == "Drop out"){
//
//                            }
//                          },
//                          child: _payOpns("Assessment",
//                              'https://aspetraining.com/sites/default/files/inline-images/Assess_1_0.png')),
                      InkWell(
                          onTap: () {
                            _catPressed(
                                context,
                                Category(16,"Board Games", icon: FontAwesomeIcons.chessBoard));
                          },
                          child: _payOpns("Aptitude",
                              'https://app.aptitudesolutions.com.au/web/images/Aptitude_Logo.png')),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Games',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return HangMan();
                            }));
                          },
                          child: _payOpns("One Word",
                              'https://www.funds-europe.com/sites/default/files/images/stories/fe/supplements/FundTech_Spring_2019/Brain.jpg')),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return PuzzleGame();
                            }));
                          },
                          child: _payOpns("Assessment",
                              'https://aspetraining.com/sites/default/files/inline-images/Assess_1_0.png')),
//                      InkWell(
//                          onTap: () {},
//                          child: _payOpns("Aptitude",
//                              'https://app.aptitudesolutions.com.au/web/images/Aptitude_Logo.png')),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Career Talk',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
              ),
              Container(
                height: 900,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Yt(id: videos[index].id)),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              videos[index].image,
                              height: 150.0,
                              width: 170.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    videos[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    videos[index].channel,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ],
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
      );
    }else{
    return Scaffold(
      appBar: AppBar(
        title: Text("Career Succours"),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AnalystScreen();
                  }));
            },
            child: Icon(
            Icons.add_box,
        ),
          ),
          SizedBox(
            width: 20.0,
          ),
//          GestureDetector(
//            onTap: (){
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) {
//                    return PuzzleGame();
//                  }));
//            },
//            child: Icon(
//            Icons.games,
//        ),
//          ),
//          SizedBox(
//            width: 20.0,
//          ),
//          GestureDetector(
//            onTap: (){
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) {
//                    return HangMan();
//                  }));
//            },
//            child: Icon(
//            Icons.games,
//        ),
//          ),
//          SizedBox(
//            width: 20.0,
//          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Psychological Tests',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          _catPressed(
                              context,
                              Category(9, "General Knowledge",
                                  icon: FontAwesomeIcons.globeAsia));
                        },
                        child: _payOpns("Behavioural",
                            'https://www.funds-europe.com/sites/default/files/images/stories/fe/supplements/FundTech_Spring_2019/Brain.jpg')),
                    InkWell(
                        onTap: () {
                          if(titleVerify == "9th-10th"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Assessment(title: titleVerify, category: "sec");
                            }));
                          }else if(titleVerify == "11th-12th"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Assessment(title: titleVerify, category: "pcb");
                            }));
                          }else if(titleVerify == "College Student"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Assessment(title: titleVerify, category: "grad");
                            }));
                          }else if(titleVerify == "Drop out"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Assessment(title: titleVerify, category: "drop");
                            }));
                          }
                        },
                        child: _payOpns("Assessment",
                            'https://aspetraining.com/sites/default/files/inline-images/Assess_1_0.png')),
                    InkWell(
                        onTap: () {},
                        child: _payOpns("Aptitude",
                            'https://app.aptitudesolutions.com.au/web/images/Aptitude_Logo.png')),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Career Articles',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
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
                      prepareTestPdf(pdfs[i].path).then((path) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullPdfViewerScreen(path)),
                        );
                      });
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
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Career Talk',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.display1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
            Container(
                height: 900,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Yt(id: videos[index].id)),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            videos[index].image,
                            height: 150.0,
                            width: 170.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  videos[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Theme.of(context).accentColor),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  videos[index].channel,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              ],
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
    );}
  }

  Future<String> prepareTestPdf(documentPath) async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
}
