
import 'package:flutter/material.dart';
import 'package:careertrack/models/YtVideo.dart';
import 'package:careertrack/ui/ytPlayer/yt.dart';

class VideoList extends StatelessWidget {
  static const String id = 'HomePgId';
  final videos = YtVideo.fetchAllVideos();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Career Talk"),
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 20.0,
          ),
          child: ListView.builder(
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
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              videos[index].channel,
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
      ),
    );
  }
}