import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floating Action Button Menu'),
      ),
      body: Container(
          // Your main content here
          ),
      floatingActionButton: buildSpeedDial(),
    );
  }

  // Function to build the speed dial widget
  Widget buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: Colors.blue,
      children: [
        SpeedDialChild(
          child: Icon(Icons.camera),
          label: 'Take a photo',
          onTap: () {
            // Action to be performed when the "Take a photo" button is pressed
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.add),
          label: 'Add a new item',
          onTap: () {
            // Action to be performed when the "Add a new item" button is pressed
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          label: 'Edit an item',
          onTap: () {
            // Action to be performed when the "Edit an item" button is pressed
          },
        ),
      ],
    );
  }
}
