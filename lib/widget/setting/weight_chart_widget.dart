import 'dart:math';

import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/layout_margin.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/commons/viewport.dart';
import 'package:d_chart/time/line.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/commons/data_model.dart';

class WeightChartWidget extends StatefulWidget {
  const WeightChartWidget({super.key});

  @override
  State<WeightChartWidget> createState() => _WeightChartWidgetState();
}

class _WeightChartWidgetState extends State<WeightChartWidget> {
  late List<TimeData> timeDataList;

  final List<TimeGroup> timeGroupList = [];

  @override
  void initState() {
    super.initState();
    generateRandomData();
  }

  void generateRandomData() {
    final now = DateTime.now();

    timeDataList = [
      TimeData(domain: DateTime(2024, 2, 3), measure: 78),
      TimeData(domain: DateTime(2024, 2, 10), measure: 78),
      TimeData(domain: DateTime(2024, 2, 17), measure: 77),
      TimeData(domain: DateTime(2024, 2, 24), measure: 77),
      TimeData(domain: DateTime(2024, 3, 2), measure: 76),
      TimeData(domain: DateTime(2024, 3, 9), measure: 76),
      TimeData(domain: DateTime(2024, 3, 16), measure: 76),
      // TimeData(domain: now.subtract(Duration(days: 6)), measure: 1200),
      // TimeData(domain: now.subtract(Duration(days: 5)), measure: 2200),
      // TimeData(domain: now.subtract(Duration(days: 4)), measure: 2600),
      // TimeData(domain: now.subtract(Duration(days: 3)), measure: 2200),
      // TimeData(domain: now.subtract(Duration(days: 2)), measure: 2100),
      // TimeData(domain: now.subtract(Duration(days: 1)), measure: 700),
      // TimeData(domain: now.subtract(Duration(days: 0)), measure: 900),
    ];

    timeGroupList.add(
      TimeGroup(
        id: '1',
        data: timeDataList,
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: DChartLineT(
          allowSliding: true,
          domainAxis: DomainAxis(
            labelAnchor: LabelAnchor.centered,
          ),
          measureAxis: MeasureAxis(desiredTickCount: 5),
          configRenderLine: ConfigRenderLine(
            areaOpacity: 0.3,
            includeArea: true,
            includePoints: true,
          ),
          groupList: timeGroupList,
        ),
      ),
    );
  }
}
