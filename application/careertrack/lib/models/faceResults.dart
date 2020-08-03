import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class FaceResults {
  static Future fetchFaceResults(String image) async {
    var url = "http://sih-emotion.herokuapp.com/classifyImage";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        await http.MultipartFile.fromPath(
            'image',
            image
        )
    );
    var res = await request.send();
    print("response");
    print(res.statusCode);
    if (res.statusCode == 200) {
      var list = await res.stream.bytesToString();
      var result = json.decode(list);
      return result["status"];
    }
  }
}
