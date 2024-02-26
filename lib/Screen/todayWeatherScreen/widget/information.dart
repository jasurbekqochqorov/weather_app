import 'package:flutter/material.dart';
import 'package:homework12/utils/extension/extension.dart';

import '../../../utils/color/color.dart';
import '../../../utils/fonts/fonts.dart';
import '../../../utils/icons/icon.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key, required this.image, required this.minTemp, required this.maxTemp, required this.temp});
  final String image;
  final String minTemp;
  final String maxTemp;
  final String temp;
  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 50.getW(), right: 50.getW(), top: 60.getH()),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(widget.image,),
              Text(
                "${widget.temp} ℃",
                style: AppTextStyle.interSemiBold.copyWith(
                    color: AppColors.white,
                    fontSize: 55.getW()),
              )
            ],
          ),
          Text(
            'Precipitations',
            style: AppTextStyle.interSemiBold.copyWith(
                color: AppColors.white, fontSize: 40.getW()),
          ),
          Row(
            children: [
              Text(
                'Max:${widget.maxTemp} ℃',
                style: AppTextStyle.interSemiBold.copyWith(
                    color: AppColors.white,
                    fontSize: 30.getW()),
              ),
              Spacer(),
              Text(
                  'Min:${widget.maxTemp} ℃',
                  style: AppTextStyle.interSemiBold.copyWith(
                      color: AppColors.white,
                      fontSize: 30.getW())),
            ],
          ),
          SizedBox(height: 30.getH()),
          Image.asset(AppImages.house),
        ],
      ),
    );
  }
}
