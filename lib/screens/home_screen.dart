import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/location_controller.dart';
import 'package:weather_app/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationController locationController =
      Get.put(LocationController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => locationController.checkLoading().isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(scrollDirection: Axis.vertical, children: const [
              SizedBox(
                height: 20,
              ),
              HeaderWidget(),
            ])),
    ));
  }
}
