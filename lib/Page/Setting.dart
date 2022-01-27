// ignore_for_file: file_names
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class SettingPage extends StatefulWidget {
  final BluetoothCharacteristic? characteristicTX;
  final BluetoothCharacteristic? characteristicRX;
  final double? vAlarm;
  final double? frpAlarm;
  final double? vfrpAlarm;
  final int? modeType;
  const SettingPage(
      {Key? key,
      required this.characteristicTX,
      required this.characteristicRX,
      required this.vAlarm,
      required this.frpAlarm,
      required this.vfrpAlarm,
      required this.modeType})
      : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double _currentSliderValue1 = 0;
  double _currentSliderValue2 = 0;
  double _currentSliderValue3 = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.home),
                  label: Text('')),
            ],
          ),
          Container(
            child: Text("Setting Application"),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text('VOLT ALARM'),
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue1,
                      min: 0.0,
                      max: 12.0,
                      divisions: 50,
                      label: _currentSliderValue1.round().toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          _currentSliderValue1 = newValue;
                        });
                      },
                      onChangeEnd: (value) {
                        print('###### value ${value}');
                        if (widget.characteristicRX != null) {
                          sendData('AT+BAT=${value.toStringAsFixed(2)}');
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue2,
                      min: 0,
                      max: 240,
                      divisions: 240,
                      label: _currentSliderValue2.round().toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          _currentSliderValue2 = newValue;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue3,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: _currentSliderValue3.round().toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          _currentSliderValue3 = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text('FRP ALARM'),
              Text('VFRP ALARM'),
              Text('MODE TYPE'),
            ],
          )
        ],
      ),
    ));
  }

  void sendData(String value) async {
    if (widget.characteristicRX!.uuid != null) {
      widget.characteristicRX!.write(utf8.encode(value));
    }
  }
}
