import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/time/line.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:intl/intl.dart';

import '../../model/CaloHistory.dart';
import '../../model/Exercise.dart';
import '../../model/Food.dart';

class CaloChartWidget extends StatefulWidget {

  String userID;

  CaloChartWidget({super.key, required this.userID});

  @override
  State<CaloChartWidget> createState() => _CaloChartWidgetState();
}

class _CaloChartWidgetState extends State<CaloChartWidget> {
  late List<TimeData> timeDataList = [];

  final List<TimeGroup> timeGroupList = [];

  List<num> totalCalo = [];

  int defaultDuration = 30;
  int defaultNetWeight = 100;

  double minGaugeValue = 0;
  double maxGaugeValue = 1500;

  List<ExerciseDetailHistory> exerciseHistories = [];
  List<Exercise> exercises = [];

  List<FoodDetailHistory> foodHistories = [];
  List<Food> foods = [];

  @override
  void initState() {
    super.initState();
    // fetchData();
    getTimeDataHistory();
  }

  // void fetchData() {
  //   final now = DateTime.now();
  //
  //   timeDataList = [
  //     TimeData(domain: DateTime(2024, 3, 17), measure: 2100),
  //     TimeData(domain: DateTime(2024, 3, 18), measure: 1900),
  //     TimeData(domain: DateTime(2024, 3, 19), measure: 1800),
  //     TimeData(domain: DateTime(2024, 3, 20), measure: 2000),
  //     TimeData(domain: DateTime(2024, 3, 21), measure: 500),
  //     TimeData(domain: DateTime(2024, 3, 22), measure: 1600),
  //     TimeData(domain: DateTime(2024, 3, 23), measure: 2500),
  //     // TimeData(domain: now.subtract(Duration(days: 6)), measure: 1200),
  //     // TimeData(domain: now.subtract(Duration(days: 5)), measure: 2200),
  //     // TimeData(domain: now.subtract(Duration(days: 4)), measure: 2600),
  //     // TimeData(domain: now.subtract(Duration(days: 3)), measure: 2200),
  //     // TimeData(domain: now.subtract(Duration(days: 2)), measure: 2100),
  //     // TimeData(domain: now.subtract(Duration(days: 1)), measure: 700),
  //     // TimeData(domain: now.subtract(Duration(days: 0)), measure: 900),
  //   ];
  //
  //   timeGroupList.add(
  //     TimeGroup(
  //       id: '1',
  //       data: timeDataList,
  //     ),
  //   );
  //
  //   setState(() {});
  // }

  Future<void> fetchData() async {
    setState(() {
      totalCalo = [];

      exerciseHistories.clear();
      exercises.clear();

      foodHistories.clear();
      foods.clear();
    });

    // Lấy dữ liệu từ Exercise History
    // await getCaloHistory(widget.userID);


    if (exerciseHistories.isNotEmpty || foodHistories.isNotEmpty) {
      await getExerciseAndFood();
    }



    setState(() {

    });
  }

  Future<void> getTimeDataHistory() async {
    final now = DateTime.now();
    //
    // await getMeasure(DateTime(now.year, now.month, now.day));
    //
    // await getMeasure(DateTime(now.year, now.month, now.day));

    for(int i = 0; i < 7; i++) {
      await getMeasure(DateTime(now.year, now.month, now.day - i));
      timeDataList.add(TimeData(domain: DateTime(now.year, now.month, now.day - i), measure: totalCalo[i]));
      print(totalCalo[i]);
    }

    // timeDataList = [
    //   // TimeData(domain: now.subtract(Duration(days: 6)), measure: 2100),
    //   // TimeData(domain: now.subtract(Duration(days: 5)), measure: 1900),
    //   // TimeData(domain: now.subtract(Duration(days: 4)), measure: 1800),
    //   // TimeData(domain: now.subtract(Duration(days: 3)), measure: 2000),
    //   // TimeData(domain: now.subtract(Duration(days: 2)), measure: 500),
    //   // TimeData(domain: now.subtract(Duration(days: 1)), measure: 1600),
    //   // TimeData(domain: now, measure: 2500),
    //   TimeData(domain: DateTime(now.year, now.month, now.day - 6), measure: 2100),
    //   TimeData(domain: DateTime(now.year, now.month, now.day - 5), measure: 1900),
    //   TimeData(domain: DateTime(now.year, now.month, now.day - 4), measure: 1800),
    //   TimeData(domain: DateTime(now.year, now.month, now.day - 3), measure: 2000),
    //   TimeData(domain: DateTime(now.year, now.month, now.day - 2), measure: 500),
    //   TimeData(domain: DateTime(now.year, now.month, now.day - 1), measure: 1600),
    //   TimeData(domain: DateTime(now.year, now.month, now.day), measure: totalCalo[0]),
    // ];

    print("ok");

    timeGroupList.add(
      TimeGroup(
        id: '1',
        data: timeDataList,
      ),
    );
  }

  Future<void> getMeasure(DateTime dateTime) async {
    setState(() {

      exerciseHistories.clear();
      exercises.clear();

      foodHistories.clear();
      foods.clear();
    });

    num total = 0;

    await getCaloHistory(widget.userID, dateTime);

    await getExerciseAndFood();

    num totalFoodCalo = 0;
    num totalExerciseCalo = 0;

    // Tính tổng calo nạp
    for(var i = 0; i < foodHistories.length; i++) {
      totalFoodCalo += (foodHistories[i].NetWeight * foods[i].FoodCalo) / defaultNetWeight;
    }


    // Tính tổng calo tiêu hao
    for(var i = 0; i < exerciseHistories.length; i++) {
      totalExerciseCalo += (exerciseHistories[i].Duration * exercises[i].ExerciseCalo) / defaultDuration;
    }

    total = (totalFoodCalo - totalExerciseCalo);

    print("Đây là total: " + total.toString());

    totalCalo.add(total);

    print(totalCalo.length);
  }

  Future<void> getCaloHistory(String userID, DateTime dateTime) async {
    try {
      String dateHistory = DateFormat('dd/MM/yyyy').format(dateTime);

      // lấy dữ liệu CaloHistory thông qua userID và date history
      final caloHistoryQuerySnapshot = await FirebaseFirestore.instance
          .collection('CaloHistory')
          .where('UserID', isEqualTo: userID)
          .where('DateHistory', isEqualTo: dateHistory)
          .get();

      // Nếu dữ liệu tồn tại
      if (caloHistoryQuerySnapshot.docs.isNotEmpty) {
        // lấy id document
        final document = caloHistoryQuerySnapshot.docs.first;

        exerciseHistories = List<ExerciseDetailHistory>.from(
            document.data()['ExerciseDetailHistory']?.map((e) => ExerciseDetailHistory(
              e['ExerciseID'] ?? '',
              e['Duration'] ?? 0,
            )) ??
                []);

        // lấy List dữ liệu FoodID và truyền vào tham số foodHistories
        foodHistories = List<FoodDetailHistory>.from(
            document.data()['FoodDetailHistory']?.map((e) => FoodDetailHistory(
              e['FoodID'] ?? '',
              e['NetWeight'] ?? 0,
            )) ??
                []);



        // Nếu dữ liệu chưa có sẽ tạo rỗng
      } else {
        exerciseHistories = [];
        foodHistories = [];
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> getExerciseAndFood() async {
    List<Exercise> fetchedExercises = [];
    List<Food> fetchedFoods = [];

    for (ExerciseDetailHistory exerciseID in exerciseHistories) {
      final exerciseDocSnapshot = await FirebaseFirestore.instance
          .collection('Exercise')
          .doc(exerciseID.ExerciseID)
          .get();

      if (exerciseDocSnapshot.exists) {
        Exercise exerciseItem = Exercise.fromFirestore(exerciseDocSnapshot);
        fetchedExercises.add(exerciseItem);
      }
    }

    for (FoodDetailHistory foodID in foodHistories) {
      final foodDocSnapshot = await FirebaseFirestore.instance
          .collection('Food')
          .doc(foodID.FoodID)
          .get();

      if (foodDocSnapshot.exists) {
        Food foodItem = Food.fromFirestore(foodDocSnapshot);
        fetchedFoods.add(foodItem);
      }
    }

    setState(() {
      exercises = fetchedExercises;
      foods = fetchedFoods;
    });
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
