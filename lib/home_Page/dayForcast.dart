import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/appIcons.dart';

class DayForcastWidget extends StatelessWidget {
  const DayForcastWidget({
    super.key,
    required this.days,
    required this.prsent,
  });
  final String days;
  final String prsent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              days,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            children: [
              Text(prsent),
              SvgPicture.asset(
                Appicons.rainy_cloudy,
                width: 50,
                height: 50,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "28°",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "/27°",
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
