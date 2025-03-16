import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentIndicatorPage extends StatefulWidget {
  const PercentIndicatorPage({super.key});

  @override
  State<PercentIndicatorPage> createState() => _PercentIndicatorPageState();
}

class _PercentIndicatorPageState extends State<PercentIndicatorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: 0.75,
                center: Text("100%"),
                progressColor: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              CircularPercentIndicator(
                radius: 60.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 10.0,
                percent: 0.4,
                center: Text(
                  "40 hours",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.yellow,
                progressColor: Colors.red,
              ),
              SizedBox(
                height: 10,
              ),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: 0.68,
                center: Text("68.0%"),
                barRadius: Radius.circular(10),
                progressColor: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
