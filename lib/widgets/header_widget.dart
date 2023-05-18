import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/location_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  final LocationController locationController =
      Get.put(LocationController(), permanent: true);

  @override
  void initState() {
    getAddress(locationController.getLatitude().value,
        locationController.getLongitude().value);
    // getAddress(52.0, 0.1);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    print(lat);
    print(lon);
    Placemark place = placemark[0];

    print(place);
    setState(() {
      city = place.name!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(city, style: const TextStyle(fontSize: 35)))
    ]);
  }
}
