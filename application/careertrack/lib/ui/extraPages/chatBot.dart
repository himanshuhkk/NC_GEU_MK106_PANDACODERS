import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageDialogflow extends StatefulWidget {
  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _handleSubmitted("hey");
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);

    var msgs = response.getListMessage();

    bool flag = false;
    msgs.forEach((msg) {

      if (msg.containsKey("text") && ListTextDialogflow(msg).listText[0].contains("Here are the links")) {
        if(!flag)
          flag = true;
        else
          return;
      }

      ChatMessage message = new ChatMessage(
        text: "",
        name: "Panda",
        type: null,
        image: "",
        quickReplies: [],
      );

      if (msg.containsKey("text")) {
        message.text = ListTextDialogflow(msg).listText.join(". ");
        message.type = "text";
      } else if (msg.containsKey("card")) {
        if (!msg["card"].containsKey("buttons")) msg["card"]["buttons"] = [];
        message.text = CardDialogflow(msg).title;
        message.type = "card";
        message.image = CardDialogflow(msg).imageUri;
      } else if (msg.containsKey("quickReplies")) {
        message.quickReplies = QuickReplies(msg).quickReplies;
        message.type = "quickReplies";
      }

      setState(() {
        _messages.insert(0, message);
      });
//      sleep(const Duration(milliseconds: 1000));
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "Me",
      type: null,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  void _handleButtonClick(String text) {
    setState(() {
      _messages.removeWhere((element) => element.type == "quickReplies");
    });
    _handleSubmitted(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Career Succour"),
      ),
      backgroundColor: Color.fromRGBO(230, 225, 219, 1.0),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (container, int index) {
                if (_messages[index].type == "quickReplies") {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: quickReply(context, _messages[index]),
                    ),
                  );
                } else {
                  return _messages[index];
                }
          },
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }

  List<Widget> quickReply(context, ChatMessage msg) {
    return <Widget>[
      new Expanded(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _getButtons(context, msg),
        ),
      ),
    ];
  }

  List<Widget> _getButtons(context, ChatMessage msg) {
    return msg.quickReplies
        .map((e) => MaterialButton(
              onPressed: () {
                _handleButtonClick(e);
              },
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              color: Theme.of(context).accentColor,
            ))
        .toList();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type, this.image, this.quickReplies});

  String text;
  String name;
  String type;
  String image;
  List<String> quickReplies;

  List<Widget> textMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('B')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Theme.of(context).accentColor)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: text.trim().contains("http")
                  ? InkWell(
                      child: new Text(
                        text,
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 17.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () async {
                        launch(
                          text,
                          forceWebView: true,
                        );
                      })
                  : Text(
                      text,
                style: TextStyle(
                fontSize: 17.0,
                ),
                    ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> cardMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('B')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              this.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Theme.of(context).accentColor),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                style: TextStyle(
                fontSize: 17.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Image.network(
                image,
                height: 150.0,
                width: 150.0,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Theme.of(context).accentColor)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text,
              style: TextStyle(color: Colors.white, fontSize: 17.0,),),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
          backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            child: new Text(
          this.name[0],
          style: new TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: type == null ?
        EdgeInsets.only(
          left: 80.0,
        ) :
        EdgeInsets.only(
          right: 80.0,
        ),
        decoration: BoxDecoration(
          color: type == null ? Color.fromRGBO(34, 155, 253, 1.0) : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getWidget(context, this.type),
        ),
      ),
    );
  }

  List<Widget> getWidget(context, type) {
    if (type == null) {
      return myMessage(context);
    } else if (type == "text") {
      return textMessage(context);
    } else if (type == "card") {
      return cardMessage(context);
    } else {
      return <Widget>[
        Container(),
      ];
    }
  }
}
