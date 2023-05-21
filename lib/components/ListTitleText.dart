import 'package:flutter/cupertino.dart';

class ListTitleText extends StatelessWidget {
  const ListTitleText(
      {super.key, required this.title, this.color, this.fontSize});
  final String title;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
