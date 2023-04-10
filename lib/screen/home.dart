import 'dart:convert';
// import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:maptast240223/screen/model.dart';
import '../controlaer/controler.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
   OpanmapApi opanmapApi = Get.put(OpanmapApi());

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>(opanmapApi.isLoading.value)?CircularProgressIndicator():ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
            return ListTile(
              leading: Text("name ${opanmapApi.welcome!.name}"),
              title: Text("lat ${opanmapApi.welcome!.lat}"),
            );

      }),
    ));
    
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Welcome? welcome;
  var isLoading=false;
  @override
  void initState() {
    super.initState();
    // getData();
  }
/*  getData()async{

      try{
        isLoading=true;
        http.Response response =await http.get(Uri.tryParse("https://raw.githubusercontent.com/mwgg/Airports/master/airports.json")!);

        if(response.statusCode ==200){
          var result = jsonDecode(response.body);
          print(result);
          welcome =Welcome.fromJson(result);
        }

      }catch (e){
        print("Erorr Fatching in MyHome");
      }
      finally{
        isLoading=false;

    }

  }*/
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
