import 'package:flutter/material.dart';

import 'Widgets/widgets.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: h,
        width: w,
        decoration: BoxDecoration(),
        child: Image(image: AssetImage("asset/cou_logo.png")),
      ),
      Container(
        color: Colors.white.withOpacity(.8),
      )
    ]);
  }
}
