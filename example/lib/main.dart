import 'package:flutter/material.dart';
import 'package:snowfall/snowfall.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // width: double.infinity,
        // height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlue, Colors.white],
            stops: [0, 0.7, 0.95],
          ),
        ),
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: () {
                print("Button pressed");
              },
              child: const Text('Press me'),
            ),
            SnowfallWidget(
              gravity: 0.1,
              windIntensity: 1,
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
            ),
            //make some buttons with print function ontap
          ],
        ),
      ),
    );
  }
}
