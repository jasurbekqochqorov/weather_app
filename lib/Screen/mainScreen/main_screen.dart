import 'package:flutter/material.dart';
import 'package:homework12/Screen/NextSevenDays/seven_days_screen.dart';
import 'package:homework12/Screen/todayWeatherScreen/today_weather.dart';
import 'package:homework12/utils/color/color.dart';
import 'package:homework12/utils/extension/extension.dart';
import 'package:homework12/utils/fonts/fonts.dart';
import 'package:homework12/utils/icons/icon.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.c_805BCA,
      body: Column(children: [
        Image.asset(AppImages.weather),
        Text('Weather',style: AppTextStyle.interBold.copyWith(
          color: AppColors.white,fontSize: 60.getW(),
        ),),
        Text('ForeCast',style: AppTextStyle.interBold.copyWith(
          color: AppColors.c_DDB130,fontSize: 60.getW(),
        ),),
        Container(
          width: width,
          margin:EdgeInsets.symmetric(horizontal:60.getW(),vertical: 40.getH()),
          child: TextButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return TodayWeatherScreen();
            }));
            },
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.c_DDB130,
                  padding: EdgeInsets.symmetric(vertical: 15.getH()),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.getW()),
                )
              ),
              child:Text('Get Start',style: AppTextStyle.interMedium.copyWith(
                color: AppColors.c_F2090F47,fontSize:20.getW()
              ),)),
        )
      ],)
    );
  }
}
