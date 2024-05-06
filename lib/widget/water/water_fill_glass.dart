import 'package:flutter/material.dart';
import 'package:healthylife/widget/water/water_history_widget.dart';

import '../../model/WaterHistory.dart';

class WaterFillGlass extends StatefulWidget {
  const WaterFillGlass({super.key});

  @override
  State<WaterFillGlass> createState() => _WaterFillGlassState();
}

class _WaterFillGlassState extends State<WaterFillGlass> {
  num totalWater = 0;
  num neededWater = 0;

  int defaultWater = 200;

  double minGaugeValue = 0;
  double maxGaugeValue = 2000;
  List<WaterDetailHistory> waterdetailHistories = [];
  bool isLoading = true;

  List<bool> imageStates = List.generate(10, (index) => true);
  final String image1 = 'assets/images/empty_glass.png';
  final String image2 = 'assets/images/water_glass.png';

  void CalculateWater() {
    setState(() {
      isLoading = true;

      waterdetailHistories.clear();
    });
    if (imageStates == true ) {
      for(var i = 0; i < waterdetailHistories.length; i++) {
        totalWater += defaultWater;
      }
    }
    for(var i = 0; i < waterdetailHistories.length; i++) {
      neededWater = maxGaugeValue - totalWater;
    }
    setState(() {
      isLoading = false;
    })
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: List.generate(10,(index) => GestureDetector(
                onTap: () {
                  setState(() {
                    imageStates[index] = !imageStates[index];
                    CalculateWater();
                  });
                },
                child: Image.asset(
                  imageStates[index]
                      ? image1 // Replace with your first image asset
                      : image2, // Replace with your second image asset
                  height: MediaQuery.of(context).size.height * (1/11),
                  width: MediaQuery.of(context).size.width * (1/12),),
              )
              ),
              ),
            Expanded(
                child: IconButton(
                  icon: Icon(Icons.add_circle_rounded),
                  onPressed: (){},
                )),
          ],
      ),
    );
  }

}
