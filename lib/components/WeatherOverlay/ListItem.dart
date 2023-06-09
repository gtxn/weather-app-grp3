import 'package:flutter/material.dart';
import '../../assets/Constants.dart';

class ListItem extends StatelessWidget {
  final String time;
  final String icon;
  final Constants style = Constants();

  // The time is a string
  ListItem({super.key, required this.time, required this.icon});

  @override
  Widget build(BuildContext context) {
    var iconArray = [Icons.sunny, Icons.cloud, Icons.umbrella];

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: style.darkGreen,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              color: style.darkGreen,
              fontSize: 25,
            ),
          ),
          ImageIcon(AssetImage("lib/assets/$icon.png")),
        ],
      ),
    );
  }
}
