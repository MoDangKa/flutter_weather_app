import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/components/additional_information/ai_item.dart';
import 'package:flutter_weather_app/components/temperature_banner.dart';
import 'package:flutter_weather_app/components/weather_forecast/wf_item.dart';
import 'package:flutter_weather_app/secrets.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> _getCurrentWeather() async {
    try {
      String cityName = 'Thailand';
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'));

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather = _getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  // weather = _getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          print(snapshot);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final list = data['list'];

          final Map<String, dynamic> bannerInfo = {
            "temp": list[0]['main']['temp'],
            "sky": list[0]['weather'][0]['main'],
          };

          final Map<String, String> additionalInfo = {
            'humidity': list[0]['main']['humidity'].toString(),
            'windSpeed': list[0]['wind']['speed'].toString(),
            'pressure': list[0]['main']['pressure'].toString(),
          };

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                TemperatureBanner(
                    temp: bannerInfo['temp']!, sky: bannerInfo['sky']),
                const SizedBox(
                  height: 20,
                ),
                // weather forecast cards
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++) ...[
                //         WFItem(
                //           time: list[i + 1]['dt'].toString(),
                //           icon: list[i + 1]['weather'][0]['main'] == "Clouds" ||
                //                   list[i + 1]['weather'][0]['main'] == "Rain"
                //               ? Icons.cloud
                //               : Icons.sunny,
                //           value: list[i + 1]['main']['temp'].toString(),
                //         )
                //       ],
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final hourlyForecast = list[index + 1];
                        final hourlySky = hourlyForecast['weather'][0]['main'];
                        final hourlyTemp =
                            hourlyForecast['main']['temp'].toString();

                        return WFItem(
                          time: hourlyForecast['dt_txt'],
                          icon: hourlySky == "Clouds" || hourlySky == "Rain"
                              ? Icons.cloud
                              : Icons.sunny,
                          value: hourlyTemp,
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                // weather forecast cards
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AIItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: additionalInfo['humidity']!,
                    ),
                    AIItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: additionalInfo['windSpeed']!,
                    ),
                    AIItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: additionalInfo['pressure']!,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
