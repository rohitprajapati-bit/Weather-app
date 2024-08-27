import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/home_Page/dayForcast.dart';
import 'package:weather/home_Page/hourlyForcast.dart';
import 'package:weather/models/chengeCity.dart';
import 'package:weather/models/currentWeather.dart';
import 'package:weather/models/dayHourlydata.dart';
import 'package:weather/utile/constent.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final searchController = TextEditingController(text: "");
  CurrentweatherData? currentweatherData;
  DayHourlyWeather? dayHourlyWeatherData;
  CityModel? chengeCity;
  final currentDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<DayHourlyWeather?> dayHourlyWeather() async {
    final lat = chengeCity?.latitude ?? "19.182755";
    final long = chengeCity?.longitude ?? "72.840157";

    final response = await http.get(Uri.parse(
        '${Constant.BASE_URL}lat=${lat}&lon=${long}&appid=${Constant.ApiKey}&units=metric'));
    log(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      dayHourlyWeatherData = DayHourlyWeather.fromJson(data);
    }
    return dayHourlyWeatherData;
  }

  Future<CurrentweatherData?> fetchWeather() async {
    final lat = chengeCity?.latitude ?? "19.182755";
    final long = chengeCity?.longitude ?? "72.840157";
    final response = await http.get(Uri.parse(
        '${Constant.BASE_HOUR_URL}lat=${lat}&lon=${long}&appid=${Constant.ApiKey}&units=metric'));
    log(response.body);

    if (response.statusCode == 200) {
      currentweatherData = currentweatherDataFromJson(response.body);
      searchController.text = currentweatherData?.name ?? '';
    }
    return currentweatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<dynamic>(
            future: Future.wait([
              fetchWeather(),
              dayHourlyWeather(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: Colors.indigo.shade200.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        child: DropdownButton<CityModel?>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Text(
                            "Select a City",
                          ),
                          value: chengeCity,
                          items: cityList.map((CityModel? value) {
                            return DropdownMenuItem<CityModel?>(
                              value: value,
                              child: Text(value?.name ?? ''),
                            );
                          }).toList(),
                          onChanged: (value) {
                            chengeCity = value;
                            setState(() {});
                          },
                        )),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                fetchWeather();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Now",
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${currentweatherData?.main?.temp}°",
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${currentweatherData?.weather?[0].description}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Text(
                                      "Feel like ${currentweatherData?.main?.feelsLike}°",
                                      style: TextStyle(fontSize: 19),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    "High:${currentweatherData?.main?.tempMax}° - Low:${currentweatherData?.main?.tempMin}°",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                "Hourly forecast",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              height: 150,
                              child: Scrollbar(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      dayHourlyWeatherData?.dayList?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    final DayList? dayData =
                                        dayHourlyWeatherData?.dayList?[index];

                                    final temperature = dayData?.main?.temp;

                                    final time = DateFormat.jm().format(
                                        (DateTime.fromMillisecondsSinceEpoch(
                                            dayData!.dt!.toInt() * 1000)));
                                    final humedty = dayData?.main?.humidity;
                                    return HourlyForcastWidget(
                                      temperature: "${temperature}°",
                                      timeData: "${time}",
                                      humidity: "${humedty}%",
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "10-day forecast",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Column(
                              children: List.generate(10, (int index) {
                                final dateTime =
                                    currentDay.add(Duration(days: index + 1));
                                final day = DateFormat('EEEE').format(dateTime);
                                return DayForcastWidget(
                                  days: day,
                                  prsent: "40%",
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
