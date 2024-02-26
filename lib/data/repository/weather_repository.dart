

import 'package:homework12/data/network/api_provider.dart';

import '../models/my_response.dart';

class WeatherRepository{

  Future<MyResponse> getSimpleWeatherInfo(String city){
    return ApiProvider.getSimpleWeatherInfo(city);
  }

  Future<MyResponse> getComplexWeatherInfo(){
    return ApiProvider.getComplexWeatherInfo();
  }
}