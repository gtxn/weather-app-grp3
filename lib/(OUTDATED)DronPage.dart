import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/ListTitleText.dart';

class DronPage extends StatelessWidget {
  const DronPage({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 150, 0, 50),
          child: Column(
            children: [
              Text(
                DateFormat('dd/MM/yy').format(now),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                DateFormat.E().format(now),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Stack(
                children: [
                  Center(
                    child: Text(
                      "18º",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      // heroTag: "topWeather",
                      onPressed: () => {},
                      child: const Icon(Icons.sunny),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const Divider(),
        ...ListTile.divideTiles(context: context, tiles: [
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: ListTitleText(title: "time of next rain"),
            trailing: ListTitleText(title: "10am"),
          ),
          ExpansionTile(
            title: const ListTitleText(title: "Next event 1"),
            children: [
              ...[for (var i = 2; i <= 10; i++) i].map((e) => ListTile(
                    title: ListTitleText(title: "Next event $e"),
                  )),
              Builder(builder: (BuildContext context) {
                return IconButton.filled(
                    onPressed: () {
                      return ExpansionTileController.of(context).collapse();
                    },
                    icon: const Icon(Icons.arrow_drop_up));
              })
            ],
          )
        ]),
      ],
    );
  }
}
