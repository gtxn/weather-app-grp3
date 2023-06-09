


// class GlobalController {
//   final RxBool _isLoading = true.obs;
//   final RxDouble _latitude = 0.0.obs;
//   final RxDouble _longitude = 0.0.obs;

//   RxBool checkLoading() => _isLoading;
//   RxDouble getLatitude() => _latitude;
//   RxDouble getLongitude() => _longitude;

//   final weatherData = WeatherData().obs;

//   Future<WeatherData> getData(Position pos) {
//     return FetchWeatherAPI().processWeatherData(pos.latitude, pos.longitude);
//   }

//   getIcalLink(link) async {
//     FetchIcal.fetchIcal(link).then((value) => print(value));
//   }

//   @override
//   void onInit() {
//     if (_isLoading.isTrue) {
//       getLocation();
//     }
//     super.onInit();
//   }

//   getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high)
//         .then((value) {
//       _latitude.value = value.latitude;
//       _longitude.value = value.longitude;
//       _isLoading.value = false;

//       return FetchWeatherAPI()
//           .processWeatherData(value.latitude, value.longitude)
//           .then((value) {
//         weatherData.value = value;
//         _isLoading.value = false;
//       });
//     });
//   }
// }
