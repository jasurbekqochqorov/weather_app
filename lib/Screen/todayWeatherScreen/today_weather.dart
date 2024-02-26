import 'package:flutter/material.dart';
import 'package:homework12/Screen/NextSevenDays/seven_days_screen.dart';
import 'package:homework12/Screen/todayWeatherScreen/widget/information.dart';
import 'package:homework12/data/local/storage_repository.dart';
import 'package:homework12/data/models/detail/one_call_data.dart';
import 'package:homework12/data/repository/weather_repository.dart';
import 'package:homework12/utils/color/color.dart';
import 'package:homework12/utils/extension/extension.dart';
import '../../data/models/my_response.dart';
import '../../data/models/simple/weather_main_model.dart';
import '../../utils/fonts/fonts.dart';

class TodayWeatherScreen extends StatefulWidget {
  const TodayWeatherScreen({super.key});

  @override
  State<TodayWeatherScreen> createState() => _TodayWeatherScreenState();
}

class _TodayWeatherScreenState extends State<TodayWeatherScreen> {
  WeatherRepository weatherRepository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_805BCA,
      body: FutureBuilder(
              future: weatherRepository.getSimpleWeatherInfo('Tashkent'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  WeatherMainModel weatherMainModel =
                      (snapshot.data as MyResponse).data as WeatherMainModel;
                  return Column(
                    children: [
                      InfoWidget(
                          image:weatherMainModel.weatherModel[0].icon.getWeatherIcon(),
                          minTemp:weatherMainModel.mainInMain.tempMin.temper().toString(),
                          maxTemp: weatherMainModel.mainInMain.tempMax.temper().toString(),
                          temp: weatherMainModel.mainInMain.temp.temper().toString()),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            boxShadow:const[
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(3, 3),
                                  color: AppColors.white)
                            ],
                            borderRadius: BorderRadius.circular(16.getW()),
                            color: AppColors.c_805BCA),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 56.getW(), vertical: 19.getH()),
                              child: Row(
                                children: [
                                  Text(
                                    'Today',
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.white,
                                        fontSize: 20.getW()),
                                  ),
                                  Spacer(),
                                  Text(
                                    weatherMainModel.dateTime
                                        .getDateTime()
                                        .toString(),
                                    style: AppTextStyle.interSemiBold.copyWith(
                                        color: AppColors.white,
                                        fontSize: 20.getW()),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: 1.getH(),
                              color: AppColors.white.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 40.getH(),
                            ),
                            SizedBox(
                              height:160.getH(),
                              child: FutureBuilder(future:weatherRepository.getComplexWeatherInfo(), builder:(context,snapshot){
                                if(snapshot.hasError){
                                  return Center(child: Text(snapshot.hasError.toString()),);
                                }
                                if(snapshot.hasData){
                                  OneCallData oneCallData=(snapshot.data as MyResponse).data as OneCallData;
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.symmetric(horizontal: 10.getW()),
                                          children: [
                                            ...List.generate(
                                                oneCallData.hourly.length,(index) => Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 14.getW(), vertical: 13.getH()),
                                                  margin: EdgeInsets.symmetric(horizontal: 10.getW()),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      gradient: const LinearGradient(colors: [
                                                        AppColors.c_F7CBFD,
                                                        AppColors.c_F6C6EC,
                                                      ])),
                                                  child:Column(
                                                    children: [
                                                      Text('${oneCallData.hourly[index].temp.toStringAsFixed(1)} ℃',style: AppTextStyle.interSemiBold.copyWith(
                                                        color: AppColors.black,fontSize:18.getW()
                                                      ),),
                                                      Image.network(oneCallData.hourly[index].weather[0].icon.getWeatherIcon(),width:50.getW(),height:50.getH(),),
                                                      SizedBox(height:10.getH(),),
                                                      Text(oneCallData.hourly[index].dt.getDateTimeHour(),style: AppTextStyle.interSemiBold.copyWith(
                                                        color: AppColors.blue,fontSize:20.getW()
                                                      ),),
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Center(child:CircularProgressIndicator(),);
                              }),
                            ),
                            SizedBox(height: 30.getH(),)
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.getH(),horizontal: 10.getW()),
                        decoration: const BoxDecoration(
                          color: AppColors.c_805BCA,
                          boxShadow: [
                            BoxShadow(
                              blurRadius:5,spreadRadius:0,color: AppColors.white,offset: Offset(0,4)
                            )
                          ]
                        ),
                        child: Row(children: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Back',style: AppTextStyle.interSemiBold.copyWith(
                              color: AppColors.white,fontSize: 30.getW()
                            ),),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: (){
                              StorageRepository.setString(key:'icon', value:weatherMainModel.weatherModel[0].icon.getWeatherIcon());
                              Navigator.push(context,MaterialPageRoute(builder: (context){
                                return SevenDaysScreen();
                              }));
                            },
                            child: Text('Next 7 days',style: AppTextStyle.interSemiBold.copyWith(
                              color: AppColors.white,fontSize: 30.getW()
                            ),),
                          )
                        ],),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
    );
  }
}

