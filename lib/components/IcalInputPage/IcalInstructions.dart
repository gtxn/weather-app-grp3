import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';

import '../../assets/Constants.dart';

class IcalInstructions extends StatelessWidget {
  const IcalInstructions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            Expandable(
              // <-- Driven by ExpandableController from ExpandableNotifier
              collapsed: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ExpandableButton(
                    // <-- Expands when tapped on the cover photo
                    child: Text(
                      "Instructions",
                      style: TextStyle(
                        color: Constants().darkGreen,
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              expanded: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ExpandableButton(
                      // <-- Expands when tapped on the cover photo
                      child: Text(
                        "Instructions",
                        style: TextStyle(
                          color: Constants().darkGreen,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Find your iCal link through Kudos, or any calendar app. For example in Google Calendar, copy the 'public address in iCal format' and submit it here.\n",
                  style: TextStyle(
                    color: Constants().darkGreen,
                  ),
                ),
                Text(
                  "Your Kudos iCal URL contains a secure token that prevents other people from accessing the events in your diary. You can deliberately share it with other people if you wish to let them see what's on your calendar.",
                  style: TextStyle(
                    color: Constants().darkGreen,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ExpandableButton(
                      // <-- Collapses when tapped on
                      child: Text(
                        "Close Instructions",
                        style: TextStyle(
                          fontSize: 15,
                          color: Constants().primary.shade100,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
