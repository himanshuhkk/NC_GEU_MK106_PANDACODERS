import 'dart:convert';

import 'package:http/http.dart' as http;

class FaceResults {
  static fetchFaceResults(image) async{

    var url = "http://sih-emotion.herokuapp.com/classifyImage";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        http.MultipartFile.fromBytes(
            'image',
            image,
        )
    );
    var res = await request.send();
    print("response");
    print(res.statusCode);
    if (res.statusCode == 200) {
      var list = json.decode(res.stream.toString());
      print(list);
    }
  }
}