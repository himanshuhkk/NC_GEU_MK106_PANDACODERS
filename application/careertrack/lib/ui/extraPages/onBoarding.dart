import 'package:careertrack/auth/SignUpIn.dart';
import 'package:careertrack/models/analystDB.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignInScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/img/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {

    VerifyQues.fetchAll(10).then((value) => print(value[0].question));

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Give Psychometric tests",
          body:
              "Give tests according to your interest and get career guidance.",
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Talk to Counsellor Bot",
          body: "Get answers to your career related queries in no time.",
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Resolve Career Doubts",
          body: "We will ensure you choose best career option.",
          image: _buildImage('img3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Answers",
          body: "We are here to answer your doubts.",
          image: _buildImage('img2'),
//          footer: RaisedButton(
//            onPressed: () {
//              introKey.currentState?.animateScroll(0);
//            },
//            child: const Text(
//              'FooButton',
//              style: TextStyle(color: Colors.white),
//            ),
//            color: Colors.lightBlue,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(8.0),
//            ),
//          ),
          decoration: pageDecoration,
        ),
//        PageViewModel(
//          title: "Title of last page",
//          bodyWidget: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: const [
//              Text("Click on ", style: bodyStyle),
//              Icon(Icons.edit),
//              Text(" to edit a post", style: bodyStyle),
//            ],
//          ),
//          image: _buildImage('img1'),
//          decoration: pageDecoration,
//        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.blue),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.blue),
      done: const Text('Login Now',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.blue)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: const Text('Home')),
//      body: const Center(child: Text("This is the screen after Introduction")),
//    );
//  }
//}
