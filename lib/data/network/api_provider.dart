

import 'dart:convert';

import 'package:homework12/data/models/detail/one_call_data.dart';
import 'package:homework12/data/models/simple/weather_main_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/const/const.dart';
import '../models/my_response.dart';

class ApiProvider{
  static Future<MyResponse> getSimpleWeatherInfo(String city) async{


    Map<String,String> _qearyParams={
       'appid':AppConst.apiKey,
       'q':city,
     };


     Uri uri=Uri.https(AppConst.simpleWeatherApiUrl,'/data/2.5/weather',_qearyParams);

     try{
       http.Response response=await  http.get(uri);
       if(response.statusCode==200){
         return MyResponse(data: WeatherMainModel.fromJson(jsonDecode(response.body)));
       }
       else{
         return MyResponse(errorText: "Other Error");
       }
     }
     catch(error){
       return MyResponse(errorText: error.toString());
     }
   }


  static Future<MyResponse> getComplexWeatherInfo() async{


    Map<String,String> _qearyParams={

      'lat':"41.311081",
      "lon":"69.240562",
      "units":"metric",
      "exclude":"minutely,current",
       'appid':AppConst.complexFirstKey,
     };


     // Uri uri=Uri.https("");

     try{
       http.Response response=await  http.get(Uri.parse('https://weatherfakeapi.free.mockoapp.net/weather-api'));
       if(response.statusCode==200){
         return MyResponse(data: OneCallData.fromJson(jsonDecode(response.body)));
       }
       else{
         return MyResponse(errorText: "Other Error");
       }
     }
     catch(error){
       return MyResponse(errorText: error.toString());
     }
   }
}