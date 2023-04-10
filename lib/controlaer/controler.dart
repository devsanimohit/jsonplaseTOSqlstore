 import 'dart:convert';

import 'package:get/get.dart';

import '../screen/model.dart';
import 'package:http/http.dart' as http;

class OpanmapApi extends GetxController {
var isLoading=false.obs;
Welcome? welcome;
Future<void>onInit()async{
  super.onInit();
  fetchData();
}
  fetchData() async{
    try{
      isLoading(true);
      http.Response response =  await http.get(Uri.tryParse("https://raw.githubusercontent.com/mwgg/Airports/master/airports.json")!);

      if(response.statusCode ==200){
        print(("response = ${response.body}"));
        var result = jsonDecode(response.body);
        print("result1 $result");
        // welcome =Welcome.fromJson(result);
        // print("latmohit${welcome?.lat}");
      }

    }catch (e){
      print("Erorr Fatching in controrlr");
    }
    finally{
      isLoading(false);
    }
  }

}

