import 'dart:async';
import 'dart:io';

import 'package:careertrack/games/puzzle/PuzzlePiece.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PuzzleGame extends StatefulWidget {
  final int rows = 3;
  final int cols = 3;

  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  File _image;
  List<Widget> pieces = [];
  final _picker = ImagePicker();

  Future getImg(source) async {
    var imageUrl = await _picker.getImage(source: source);

    final File image = File(imageUrl.path);

    if (image != null) {
      setState(() {
        _image = image;
        pieces.clear();
      });

      splitImage(Image.file(image));
    }
  }

  // we need to find out the image size, to be used in the PuzzlePiece widget
  Future<Size> getImageSize(Image image) async {
    final Completer<Size> completer = Completer<Size>();

    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener(
      (ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      },
    ));

    final Size imageSize = await completer.future;

    return imageSize;
  }

  // here we will split the image into small pieces using the rows and columns defined above; each piece will be added to a stack
  void splitImage(Image image) async {
    Size imageSize = await getImageSize(image);

    for (int x = 0; x < widget.rows; x++) {
      for (int y = 0; y < widget.cols; y++) {
        setState(() {
          pieces.add(PuzzlePiece(
              key: GlobalKey(),
              image: image,
              imageSize: imageSize,
              row: x,
              col: y,
              maxRow: widget.rows,
              maxCol: widget.cols,
              bringToTop: this.bringToTop,
              sendToBack: this.sendToBack));
        });
      }
    }
  }

  // when the pan of a piece starts, we need to bring it to the front of the stack
  void bringToTop(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.add(widget);
    });
  }

  // when a piece reaches its final position, it will be sent to the back of the stack to not get in the way of other, still movable, pieces
  void sendToBack(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.insert(0, widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Puzzle Game"),
        actions: <Widget>[
          Center(
              child: Text(
                "00:00",
                style: TextStyle(fontSize: 20.0),
              )
          ),
          SizedBox(width: 20.0,),
        ],
      ),
      body: new Center(
          child: _image == null
              ? new Text('No image selected.')
              : Stack(children: pieces)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new ListTile(
                        leading: new Icon(Icons.camera),
                        title: new Text('Camera'),
                        onTap: () {
                          getImg(ImageSource.camera);
                          // this is how you dismiss the modal bottom sheet after making a choice
                          Navigator.pop(context);
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.image),
                        title: new Text('Gallery'),
                        onTap: () {
                          getImg(ImageSource.gallery);
                          // dismiss the modal sheet
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        tooltip: 'New Image',
        child: Icon(Icons.add),
      ),
    );
  }
}
