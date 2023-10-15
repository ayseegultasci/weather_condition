import 'package:flutter/material.dart';
import 'package:flutter_homework_seven/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 43, 169, 148),
              title: Text("Weather Conditions"),
              titleTextStyle: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: fetchWeather(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('An error occurred.\n${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final weatherData = snapshot.data;
                          return WeatherInfo(weatherData: weatherData!);
                        } else {
                          return Text("There is no data!");
                        }
                      })
                ],
              ),
            )));
  }
}

class WeatherInfo extends StatelessWidget {
  final List<WeatherData> weatherData;
  WeatherInfo({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: weatherData.map((data) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  " Location:${data.location}",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Temperature:${data.temperature}°C",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Humidity:${data.humidity}%",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " WindSpeed:${data.windSpeed}",
                  style: TextStyle(fontSize: 20),
                ),
              
              ],
            ),
            
            SizedBox(height: 10),
            Divider(),
          ],
        );
      }).toList(),
    );
  }
}
