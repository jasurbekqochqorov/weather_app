import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homework12/data/local/storage_repository.dart';
import 'package:homework12/data/models/detail/one_call_data.dart';
import 'package:homework12/data/models/my_response.dart';
import 'package:homework12/data/repository/weather_repository.dart';
import 'package:homework12/utils/color/color.dart';
import 'package:homework12/utils/extension/extension.dart';
import 'package:homework12/utils/fonts/fonts.dart';
import 'package:homework12/utils/icons/icon.dart';

class SevenDaysScreen extends StatefulWidget {
  const SevenDaysScreen({super.key});

  @override
  State<SevenDaysScreen> createState() => _SevenDaysScreenState();
}

class _SevenDaysScreenState extends State<SevenDaysScreen> {
  WeatherRepository weatherRepository =WeatherRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_805BCA,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_outlined,color: AppColors.c_DDB130,),),
        centerTitle: true,
        title: Text('Next 7 days',style: AppTextStyle.interSemiBold.copyWith(
          color: AppColors.c_DDB130,fontSize:25.getW()
        ),),
        backgroundColor: AppColors.c_805BCA,
      ),
      body: FutureBuilder(
        future: weatherRepository.getComplexWeatherInfo(),builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.hasError.toString()),);
          }
          if(snapshot.hasData){
            OneCallData oneCallData=(snapshot.data as MyResponse).data as OneCallData;
            return Column(
              children: [
              Padding(padding: EdgeInsets.symmetric(horizontal:40.getW(),vertical:20.getH()),
              child: Column(
                children: [
                Text(oneCallData.timezone,style: AppTextStyle.interSemiBold.copyWith(
                    color: AppColors.white,fontSize:40.getW()
                ),),
               SizedBox(height: 10.getH(),),
               Row(children: [
                 Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20.getW()),
                       border: Border.all(width: 3.getW(),color: AppColors.blue)
                   ),
                   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                   child:Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(children: [
                         SvgPicture.asset(AppImages.sun,width: 30.getW(),height: 30.getH(),),
                         SizedBox(width: 7.getW(),),
                         Text('Sunrise',style: AppTextStyle.interSemiBold.copyWith(
                           color: AppColors.white,fontSize: 18.getW()
                         ),),
                       ],),
                       SizedBox(height:5.getH(),),
                       Text("${oneCallData.daily[0].sunrise.getDateTimeHour()} AM",style: AppTextStyle.interBold.copyWith(
                         color:AppColors.white,fontSize:24.getW()
                       ),),
                       SizedBox(height:5.getH(),),
                       Text("Sunset:${oneCallData.daily[0].sunset.getDateTimeHour()} PM",style: AppTextStyle.interSemiBold.copyWith(
                         color: AppColors.white.withOpacity(0.7),fontSize:16.getW()
                       ),)
                     ],),
                 ),
                 Spacer(),
                 Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20.getW()),
                       border: Border.all(width: 3.getW(),color: AppColors.blue)
                   ),
                   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                   child:Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(children: [
                         Image.asset(AppImages.moon,width: 30.getW(),height:30.getH(),),
                         SizedBox(width: 7.getW(),),
                         Text('Moonrise',style: AppTextStyle.interSemiBold.copyWith(
                           color: AppColors.white,fontSize: 18.getW(),
                         ),),
                       ],),
                       SizedBox(height:5.getH(),),
                       Text("${oneCallData.daily[0].moonrise.getDateTimeHour()} AM",style: AppTextStyle.interBold.copyWith(
                           color:AppColors.white,fontSize:24.getW()
                       ),),
                       SizedBox(height:5.getH(),),
                       Text("Sunset:${oneCallData.daily[0].moonset.getDateTimeHour()} PM",style: AppTextStyle.interSemiBold.copyWith(
                           color: AppColors.white.withOpacity(0.7),fontSize:16.getW()
                       ),)
                     ],),
                 ),
               ],),
               SizedBox(height:20.getH(),),
              ],)),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal:20.getW()),
                    children: [
                      ...List.generate(oneCallData.daily.length-1, (index) =>  Container(
                        margin: EdgeInsets.symmetric(vertical:10.getH()),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent.shade700,
                            borderRadius: BorderRadius.circular(16.getW()),
                            border: Border.all(width: 3.getW(),color: AppColors.blue)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.getH(),horizontal:10.getW()),
                        child: Row(children: [
                          Text(oneCallData.daily[index+1].dt.getDateWeek(),style: AppTextStyle.interSemiBold.copyWith(
                              color: Colors.black,fontSize: 22.getW()
                          ),),
                          const Spacer(),
                          Text("${oneCallData.hourly[index].temp} ℃",style: AppTextStyle.interSemiBold.copyWith(
                              color: AppColors.c_DDB130,fontSize:22.getW()
                          ),),
                          Image.network(oneCallData.daily[index].weather[0].icon.getWeatherIcon(),width:50.getW(),height: 50.getH(),)
                        ],),
                      ))
                    ],
                  ),
                )
            ],);
          }
          return Center(child: CircularProgressIndicator(),);
      },
      )
    );
  }
}
