import 'dart:math';
import 'package:flutter/material.dart';
import 'package:megnetoo_live/models/live_data.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

class MagnitudeProvider extends ChangeNotifier {
  double x = 0;
  double y = 0;
  double z = 0;
  double magnitude = 0;
  int time = 0;
  List<LiveData> values = [];
  Vector3 magnetometer = Vector3.zero();
  final Vector3 _accelerometer = Vector3.zero();
  final Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupValue = 2;
  bool isListening = false;

  changeValues() {
    isListening = !isListening;
      motionSensors.magnetometer.listen((MagnetometerEvent event) {
        if(isListening)
          {
            magnetometer.setValues(event.x, event.y, event.z);
            var matrix =
            motionSensors.getRotationMatrix(_accelerometer, magnetometer);
            _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
            x = magnetometer.x;
            y = magnetometer.y;
            z = magnetometer.z;
            magnitude = sqrt((pow(x, 2)) + (pow(y, 2)) + (pow(z, 2)));
            values.add(LiveData(x, y, z, magnitude, time++));
            if (values.length > 40) {
              values.removeAt(0);
            }
            notifyListeners();
          }
        else{
          motionSensors.magnetometer.drain();
          x = 0;
          y = 0;
          z = 0;
          magnitude = 0;
          notifyListeners();
        }
      });
  }

  setUpdateInterval(int? groupValue,int interval){
    motionSensors.magnetometerUpdateInterval = interval;
    this.groupValue = groupValue;
    notifyListeners();
  }
}
