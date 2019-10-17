import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      print('Data was passed correctly');

      return jsonDecode(data);
    } else {
      print('Data was not passed correctly');
      print(response.statusCode);
    }
  }
}
