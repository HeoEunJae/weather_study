import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;

  Network(this.url);

  Future<dynamic> getJsonData() async {
    // Json 파싱 dynamic을 쓰는이유 String int 등 값을 가져올때 형식에 얽메이지 않기 위해서 사용
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body; // body가 내용 json 내용 전체 가져오는것
      var parsingData =
          jsonDecode(jsonData); // jsonDecode String형(문자형)으로 디코딩 해주는 것
      return parsingData;
    }
  }
}
