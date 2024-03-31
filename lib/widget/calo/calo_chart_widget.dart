import 'dart:math';

import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/time/line.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/commons/data_model.dart';

class CaloChartWidget extends StatefulWidget {
  const CaloChartWidget({super.key});

  @override
  State<CaloChartWidget> createState() => _CaloChartWidgetState();
}

class _CaloChartWidgetState extends State<CaloChartWidget> {
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
      TimeData(domain: DateTime(2024, 3, 17), measure: 2100),
      TimeData(domain: DateTime(2024, 3, 18), measure: 1900),
      TimeData(domain: DateTime(2024, 3, 19), measure: 1800),
      TimeData(domain: DateTime(2024, 3, 20), measure: 2000),
      TimeData(domain: DateTime(2024, 3, 21), measure: 500),
      TimeData(domain: DateTime(2024, 3, 22), measure: 1600),
      TimeData(domain: DateTime(2024, 3, 23), measure: 2500),
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
          measureAxis: MeasureAxis(
            desiredTickCount: 6,
            // labelFormat: (measure) {
            //   return '${measure!.round()} kg';
            // },
          ),
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
