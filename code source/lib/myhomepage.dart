import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'temparature_page.dart';
import 'humidity_page.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:syncfusion_flutter_sliders/sliders.dart';


class MyHomePage extends StatefulWidget {
  final BluetoothDevice server;
  MyHomePage({this.server});

  @override
  MyHomePageState createState() => new MyHomePageState(this.server);
}

class MyHomePageState extends State<MyHomePage> {
  // variables de base temperature humidité
  double  _temperature = 37.5;
  int  _humidity = 40;
  String name;
  String adress;
  bool isConnected;
  // init du bluetooth
  final BluetoothDevice server;
  static final clientID = 0;
  BluetoothConnection connection;

  MyHomePageState(this.server){
    this.name = server.name;
    this.adress = server.address;
    this.isConnected = server.isConnected;
  }

 /*@override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
  }*/



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Appareil : $name"),
                        Text("Adresse  : $adress"),
                      ]
                  )
              ),
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  Card(
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              if (this._temperature == 0)
                                const ListTile(
                                    leading: Icon(Icons.thermostat_rounded, size: 50),
                                    title: Text('Temperature'),
                                    subtitle: Text('demandé : ... \nactuel : ...'),
                                    isThreeLine: true,
                                    trailing: Text("edit"),
                                )
                              else
                                ListTile(
                                    leading: const Icon(Icons.thermostat_rounded, size: 50),
                                    title: const Text('Temperature'),
                                    subtitle: Text("demandé : ${this._temperature} \nactuel : ..."),
                                    isThreeLine: true,
                                    trailing: ElevatedButton(onPressed: () => _waitValueTemperature(context), child: Text("Edit")),
                                )
                          ],
                      ),
                  ),
                  Card(
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              if (this._temperature == 0)
                                  const ListTile(
                                      leading: Icon(Icons.opacity, size: 50),
                                      title: Text('Temperature'),
                                      subtitle: Text('demandé : ... \nactuel : ...'),
                                      isThreeLine: true,
                                      trailing: Text("edit"),
                                  )
                              else
                                  ListTile(
                                      leading: const Icon(Icons.opacity, size: 50),
                                      title: const Text('Humidité'),
                                      subtitle: Text("demandé : ${this._humidity} % \nactuel : ..."),
                                      isThreeLine: true,
                                      trailing: ElevatedButton(onPressed: () => _waitValueHumidity(context), child: Text("Edit")),
                                  )
                          ],
                      ),
                  ),
                  Card(
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              const ListTile(
                                  leading: Icon(Icons.timer, size: 50),
                                  title: Text('Temps'),
                                  subtitle: Text('restant : ...'),
                                  isThreeLine: true,
                              ),
                          ],
                      ),
                  ),
              ]
          )
        ]
      )
    );
  }

  void _waitValueTemperature(BuildContext context) async{
    // lance la page et attend que la valeur arrive
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TemperaturePage(temperature: this._temperature)
        )
    );

    // une fois qu'on retourne au menu, le resultat est mis à jour
    if (result != null) {
      setState(() {
        _temperature = result;
      });
    }
  }

  void _waitValueHumidity(BuildContext context) async{
    // lance la page et attend que la valeur arrive
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HumidityPage(humidity: this._humidity)
        )
    );

    // une fois qu'on retourne au menu, le resultat est mis à jour
    if (result != null) {
      setState(() {
        _humidity = result;
      });
    }
  }

}