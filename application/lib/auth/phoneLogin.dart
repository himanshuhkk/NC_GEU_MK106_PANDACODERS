import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhoneLoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            //TODO: Send to main screen
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print("error");
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
//                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          //TODO: Send to main screen
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("LOGIN"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

//*************************************************************************************************

class PhonePage extends StatefulWidget {
  PhonePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
//  static final List<String> _dropdownItems = <String>['India', 'USA'];
  static List<CountryModel> _dropdownItems = new List();
  final formKey = new GlobalKey<FormState>();
  final _codeController = TextEditingController();

  var controller = new MaskedTextController(mask: '000 000 0000');
  CountryModel _dropdownValue;
  String _errorText;
  TextEditingController nameInputController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dropdownItems.add(CountryModel(country: 'India', countryCode: '+91'));
      _dropdownItems.add(CountryModel(country: 'USA', countryCode: '+1'));
      _dropdownItems
          .add(CountryModel(country: 'Afghanistan', countryCode: '+93'));
      _dropdownItems
          .add(CountryModel(country: 'Australia', countryCode: '+61'));
      _dropdownItems.add(CountryModel(country: 'Brazil', countryCode: '+55'));
      _dropdownValue = _dropdownItems[0];
      phoneController.text = _dropdownValue.countryCode;
    });
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Firestore.instance
                .collection("users")
                .document(user.uid)
                .setData({
                  "uid": user.uid,
                  "name": nameInputController.text,
                  "phone": phoneController.text,
                  "title": selectedReportList,
                })
                .then((result) => {
                      //TODO: Send to main screen
                      nameInputController.clear(),
                    })
                .catchError((err) => print(err));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print("error");
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
//                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Firestore.instance
                              .collection("users")
                              .document(user.uid)
                              .setData({
                                "uid": user.uid,
                                "name": nameInputController.text,
                                "phone": phoneController.text,
                                "title": selectedReportList,
                              })
                              .then((result) => {
                                    //TODO: Send to main screen
                                    nameInputController.clear(),
                                  })
                              .catchError((err) => print(err));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  List<String> reportList = [
    "9th-10th",
    "11th-12th",
    "College Student",
    "Drop out",
    "Others"
  ];

  String selectedReportList = "";

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Select Your Class"),
            content: MultiSelectChip(
              reportList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Done",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
//                  print(selectedReportList);
                  if (selectedReportList != '' &&
                      nameInputController.text != '' &&
                      phoneController.text != '') {
                    final phone = phoneController.text.trim() +
                        controller.text.replaceAll(' ', '');
//                    print(phone);
                    loginUser(phone, context);
                  } else {}
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Login with Mobile'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
//              Container(
//                height: double.infinity,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    colors: [
//                      Color(0xFF73AEF5),
//                      Color(0xFF61A4F1),
//                      Color(0xFF478DE0),
//                      Color(0xFF398AE5),
//                    ],
//                    stops: [0.1, 0.4, 0.7, 0.9],
//                  ),
//                ),
//              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Enter your mobile number',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
//                      SizedBox(height: 20.0),
//                      _buildEmailTF(),
                      SizedBox(height: 20.0),
                      _buildNameTF(),
                      SizedBox(height: 20.0),
                      _buildCountry(),
                      SizedBox(height: 20.0),
                      _buildPhonefiled(),
//                      _buildForgotPasswordBtn(),
//                      _buildRememberMeCheckbox(),
                      _buildPhoneBtn(),
//                      _buildSignUpWithText(),
//                      _buildSocialBtnRow(),
//                      _buildPhoneBtn(),
//                      _buildLogBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
//            color: Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: nameInputController,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_add,
                color: Theme.of(context).accentColor,
              ),
              hintText: 'Enter your Name',
              hintStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountry() {
    return FormField(
      builder: (FormFieldState state) {
        return DropdownButtonHideUnderline(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new InputDecorator(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                  fillColor: Colors.orange,
                  filled: false,
                  hintText: 'Choose Country',
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Theme.of(context).accentColor,
                  ),
                  labelText:
                      _dropdownValue == null ? 'Where are you from' : 'From',
                  errorText: _errorText,
                ),
                isEmpty: _dropdownValue == null,
                child: new DropdownButton<CountryModel>(
                  value: _dropdownValue,
                  isDense: true,
                  onChanged: (CountryModel newValue) {
                    print('value change');
                    print(newValue);
                    setState(() {
                      _dropdownValue = newValue;
                      phoneController.text = _dropdownValue.countryCode;
                    });
                  },
                  items: _dropdownItems.map((CountryModel value) {
                    return DropdownMenuItem<CountryModel>(
                      value: value,
                      child: Text(
                        value.country,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhonefiled() {
    return Row(
      children: <Widget>[
        new Expanded(
          child: new TextFormField(
            style: TextStyle(color: Theme.of(context).accentColor),
            controller: phoneController,
            enabled: false,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Theme.of(context).accentColor),
              labelStyle: TextStyle(color: Theme.of(context).accentColor),
              filled: false,
              prefixIcon: Icon(
                FontAwesomeIcons.globe,
                color: Theme.of(context).accentColor,
              ),
              labelText: 'code',
              hintText: "Country code",
            ),
          ),
          flex: 2,
        ),
        new SizedBox(
          width: 10.0,
        ),
        new Expanded(
          child: new TextFormField(
            style: TextStyle(color: Theme.of(context).accentColor),
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Theme.of(context).accentColor),
              labelStyle: TextStyle(color: Theme.of(context).accentColor),
              filled: false,
              labelText: 'mobile',
              hintText: "Mobile number",
              prefixIcon: new Icon(
                Icons.mobile_screen_share,
                color: Theme.of(context).accentColor,
              ),
            ),
            onSaved: (String value) {},
          ),
          flex: 5,
        ),
      ],
    );
  }

  Widget _buildPhoneBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _showReportDialog();
//          Navigator.push(context, MaterialPageRoute(builder: (context){
//            return PhonePage();
//          }));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          'Get OTP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}

class CountryModel {
  String country = '';
  String countryCode = '';

  CountryModel({
    this.country,
    this.countryCode,
  });
}

//*******************************************************************************************

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(String) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  String selectedChoice = "";

//  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              widget.onSelectionChanged(selectedChoice);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
