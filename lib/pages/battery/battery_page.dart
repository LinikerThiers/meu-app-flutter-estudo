import 'package:battery_plus/battery_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  var battery = Battery();
  var statusDaBateria = "";
  int level = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPage();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      print(state);
    });
  }

  initPage() async {
    level = await battery.batteryLevel;
    setState(() {
      statusDaBateria = level.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("STATUS_BATERIA".tr()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularPercentIndicator(
              radius: 60.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 10.0,
              percent: level / 100,
              center: Text(
                "$statusDaBateria%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey.shade400,
              progressColor: Colors.purple,
            ),
          ),
        ],
      ),
    ));
  }
}
