import 'package:flutter/material.dart';

import '../../assets/Constants.dart';

class IcalSubmission extends StatelessWidget {
  const IcalSubmission({
    super.key,
    required this.style,
    required this.myController,
  });

  final Constants style;
  final myController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
      decoration: BoxDecoration(
        color: Constants().primary.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Enter your iCal link here:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Constants().darkGreen,
              fontSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: myController,
              style: TextStyle(
                color: Constants().darkGreen,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText:
                    'If you would like to sync the app with your calendar, enter the link here.\n',
                hintStyle: TextStyle(color: Constants().gray),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: style.darkGreen,
              foregroundColor: style.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              // send back to main screen with ical link
              Navigator.pop(context, myController.text);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
