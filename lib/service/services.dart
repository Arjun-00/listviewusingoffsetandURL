import 'dart:convert';
import 'package:simple_getx_api/class/datas.dart';
import 'package:http/http.dart' as http;

class Services{
  static Future<dynamic> getApiDatas(int pagenumber) async{
    final responces = await http.Client().get(Uri.parse("https://reqres.in/api/users?page=$pagenumber"));
    if(responces.statusCode ==200){
      return Datas.fromJson(json.decode(responces.body));
    }else{
      return "check";
    }
  }
}