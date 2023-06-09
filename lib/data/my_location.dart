import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? latitude2;
  double? longitude2;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          // geolocator 가 위도와 경도를 정보를 가져온다 position 변수는 미래의 시점에서 위도와 경도를 받기 때문에 await를 사용해야한다.
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
      // print(position);
      print('현재 내 위치');
    } catch (e) {
      print('There was a problem with the internet connection');
    }
  }
}
