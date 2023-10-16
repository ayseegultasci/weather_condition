import 'package:http/http.dart' as http;

import 'dart:convert';

Future<List<WeatherData>> fetchWeather() async {
  List<String> cities = [
    "Ankara",
    "Eskisehir",
    "Istanbul",
    "Izmir",
    "Trabzon",
  ];
  final apiKey = 'kendiAPIanahtarinizigiriniz!';
  final List<WeatherData> weatherDataList = [];
  for (final city in cities) {
    final response = await http.get(
      Uri.parse(
        'https://weatherapi-com.p.rapidapi.com/current.json?q=$city',
      ),
      headers: {
        'X-RapidAPI-Key': '$apiKey',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com',
      },
    );
    if (response.statusCode != 200) {
      print("Error Response Code: ${response.statusCode}");
      print("Error Response Body: ${response.body}");
      throw Exception("Data isn't get!");
    }

    final weatherData = WeatherData.fromJson(jsonDecode(response.body));
    weatherDataList.add(weatherData);
  }
  return weatherDataList;
}

class WeatherData {
  final String location;
  final double temperature;
  final int humidity;
  final double windSpeed;

  WeatherData(
      {required this.location,
      required this.temperature,
      required this.humidity,
      required this.windSpeed});
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: json['location']['name'],
      temperature: json['current']['temp_c'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_mph'],
    );
  }
}
