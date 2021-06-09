import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TemperaturePage extends StatefulWidget {
  final double temperature;

  TemperaturePage({@required this.temperature});

  @override
  TemperaturePageState createState() => new TemperaturePageState(this.temperature);
}

class TemperaturePageState extends State<TemperaturePage> {
  double temperature;
  int int_temperature;
  TemperaturePageState(this.temperature);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(title: Text('temperature')),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => decrease(),
                    child:
                    Text(
                      "-",
                      style: TextStyle( fontSize: 20.0),
                    ),
                ),
                Text(
                  "${this.temperature}",
                  style: TextStyle( fontSize: 30.0),
                ),
                ElevatedButton(
                    onPressed: () => increase(),
                    child:
                      Text(
                        "+",
                        style: TextStyle( fontSize: 20.0),
                      )
                ),
              ],


            ),
            ElevatedButton(
                onPressed: () => _sendDataBack(context),
                child:
                Text(
                  "OK",
                  style: TextStyle(fontSize: 20.0),
                ),
            ),
          ],
        )
    );
  }

  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, temperature);
  }

  void increase()
  {
    if (this.mounted) {
      setState(() {
        temperature+=0.1;
        temperature = temperature * 10 ;
        int_temperature = temperature.toInt();
        print(int_temperature);
        temperature = int_temperature.toDouble();
        temperature = temperature/10;
      });
    }
  }

  void decrease()
  {
    if (this.mounted) {
      setState(() {
        temperature-=0.1;
        temperature = temperature * 10 ;
        int_temperature = temperature.toInt();
        print(int_temperature);
        temperature = int_temperature.toDouble();
        temperature = temperature/10;
      });
    }
  }

}