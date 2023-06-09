import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_test/data/my_location.dart';
import 'package:test_test/data/network.dart';
import 'package:test_test/Screens/weather_screen.dart';

const apikey = '12f477b2b9e02710c8e84289e063ea47';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;
  @override
  void initState() {
    // 위젯이 생성될때 처음으로 호출되는 메서드
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    latitude3 = myLocation.latitude2; // 위도
    longitude3 = myLocation.longitude2; // 경도
    // print(latitude3);
    // print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey'); // api받아오고 {} 란에 api key를 입력

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => WeatherScreen(
                  parseWeatherData: weatherData,
                  parseAirPollution: airData,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
