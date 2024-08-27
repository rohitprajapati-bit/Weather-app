import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/appIcons.dart';

class HourlyForcastWidget extends StatelessWidget {
  
  const HourlyForcastWidget({
    super.key,
    required this.temperature,
    required this.timeData,
    required this.humidity,
  });
  final String temperature;
  final String timeData;
  final String humidity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Text(
            temperature,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(humidity, style: TextStyle(color: Colors.blue)),
          SvgPicture.asset(
            Appicons.rainy_cloudy,
            width: 50,
            height: 50,
          ),
          Text(timeData)
        ],
      ),
    );
  }
}
