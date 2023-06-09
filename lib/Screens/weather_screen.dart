import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:test_test/model/model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen(
      {super.key, this.parseWeatherData}); // 생성자를 통해 api 데이터 가져오기
  final dynamic parseWeatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityname;
  int? temp;
  Widget? icon;
  var date = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    double temp2 = weatherData['main']['temp'];
    temp = temp2.round();
    int condition = weatherData['weather'][0]['id'];
    cityname = weatherData['name'];
    icon = model.getWeatherIcon(condition);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: Text(''),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.near_me), iconSize: 30.0),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.location_searching),
              iconSize: 30.0),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // 날짜 도시 온도 날씨 대기질 미세먼지 초미세먼지 관련 컬럼 최상위 컬럼
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      // 도시 날짜 온도 날씨 관련 컬럼
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          // 도시와 날짜 시간 관련 컬럼
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 150.0,
                            ),
                            Text(
                              '$cityname',
                              style: GoogleFonts.lato(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              // 날짜 시간 관련 로우
                              children: [
                                TimerBuilder.periodic(
                                  (const Duration(minutes: 1)),
                                  builder: (context) {
                                    print(getSystemTime());
                                    return Text(
                                      getSystemTime(),
                                      style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          // 온도와 날씨 관련 컬럼
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                // SvgPicture.asset('svg/climacon-sun.svg'),
                                icon!,
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'clear sky',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    // 대기질 지수, 미세 먼지, 초미세먼지 관련 컬럼
                    children: [
                      const Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질 지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Image.asset(
                                'image/bad.png',
                                width: 37.0,
                                height: 35.0,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '매우나쁨',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '174.75',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '㎍/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '84.03',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '㎍/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
