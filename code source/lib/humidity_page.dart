import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HumidityPage extends StatefulWidget {
  final int humidity;

  HumidityPage({@required this.humidity});

  @override
  HumidityPageState createState() => new HumidityPageState(this.humidity);
}

class HumidityPageState extends State<HumidityPage> {
  int humidity;
  HumidityPageState(this.humidity);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(title: Text('humidité')),
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
                  "${this.humidity}",
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
    //renvoie la valeur au menu
    Navigator.pop(context, humidity);
  }

  void increase()
  {
    if (this.mounted) {
      setState(() {
        humidity++;
      });
    }
  }

  void decrease()
  {
    if (this.mounted) {
      setState(() {
        humidity--;
      });
    }
  }

}