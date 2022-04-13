import 'dart:convert';
import 'package:http/http.dart';
import '../model/ProductItemModel.dart';

class HttpService {
  String baseUrl = "http://www.splashbase.co/api/v1/images/latest";

  Future<ProductItemModel> getProductItems() async {
   print("api call");
    var response = await get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var responsedata= jsonDecode(response.body);
      print("the data is $responsedata");
      return ProductItemModel.fromJson(responsedata);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception();
    }
  }
}

