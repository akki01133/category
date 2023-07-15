import 'dart:convert';

import 'package:category/model/product_model.dart';
import 'package:http/http.dart';

class UserRepository
{
  String endpoint= 'http://15.206.16.162:8080';
 Future<Map<String,dynamic>> getCategories() async {
    String reqURL = endpoint + "/getData";
    print("enpoint :"+reqURL);
    Response response = await get(Uri.parse(reqURL));
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);

    //   final List productList=data['data']['products'];
    //   return productList.map((e) => ProductModel.fromJson(e)).toList();
    return data;
    }
    else{
      print("got an exception");
      throw Exception(response.reasonPhrase);
    }
  }
}