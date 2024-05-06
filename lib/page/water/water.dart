import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/page/food_calo/food_calo.dart';
import 'package:healthylife/page/home/home_page.dart';
import 'package:healthylife/page/walking/walking_page.dart';
import 'package:healthylife/util/color_theme.dart';
import 'package:healthylife/widget/calo/calo_chart_widget.dart';
import 'package:healthylife/widget/calo/calo_gauge_widget.dart';

import '../../widget/water/water_chart_widget.dart';
import '../../widget/water/water_fill_glass.dart';
import '../../widget/water/water_history_widget.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            'Lượng nước uống',
            style: GoogleFonts.getFont(
              'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: ColorTheme.lightGreenColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.03,
          horizontal: MediaQuery.of(context).size.height * 0.02,
        ),

        child: Container(
          child: Column(
          children: [
            WaterHistoryWidget(userID: 'lCIdlGoR2V2HPOEOFkF9'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  WaterFillGlass(),
                  Divider(height: 0, thickness: 2, color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.healing),
                    title: Text(
                      'Tình trạng',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Thiếu nước',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Divider(height: 0, thickness: 2, color: Colors.grey),
                  WaterChartWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
              ),
            ),
          ],
        ),
       )
      )
    );
  }
}
