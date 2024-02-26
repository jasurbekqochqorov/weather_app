import 'package:intl/intl.dart';
double height = 0.0;
double width = 0.0;

extension Size on int {
  double getH() {
    return (this /896) * height;
  }

  double getW() {
    return (this /414) * width;
  }
}


extension Temp on double{
  double temper(){
    return this-273.12;
  }
}

extension ParseDateTime on int{
  String getDateTime(){
    DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(this*1000);
    return DateFormat.yMEd('en_US').format(dateTime);
  }
}

extension ParseDateWeek on int{
  String getDateWeek(){
    DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(this*1000);
    return DateFormat.E().format(dateTime);
  }
}
extension ParseDateTimeHour on int{
  String getDateTimeHour(){
    DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(this*1000);
    return DateFormat('hh:mm').format(dateTime);
  }
}

extension ParseImage on String{
  getWeatherIcon(){
    return 'https://openweathermap.org/img/wn/$this@2x.png';
  }
}