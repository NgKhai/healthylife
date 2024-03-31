import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/page/bmi/bmi_page.dart';
import 'package:healthylife/page/calo/calo_page.dart';
import 'package:healthylife/widget/home/home_bmi_gauge_widget.dart';
import 'package:intl/intl.dart';

import '../../widget/home/home_calo_gauge_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/147/147142.png"),
          ),
        ),
        title: Text(
          'Nguyễn Khải',
          style: GoogleFonts.getFont(
            'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
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
        backgroundColor: const Color(0xFFDE5044),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.025),
                child: Text(
                  'Chỉ số Calories',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              HomeCaloGaugeWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Chỉ số BMI
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.025),
                        child: Text(
                          'Chỉ số BMI',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      HomeBMIGaugeWidget(),
                    ],
                  ),
                  //-----------

                  // Chỉ số Fat
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.025),
                        child: Text(
                          'Chỉ số Fat',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BMIPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 * 0.8,
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          AnimatedRadialGauge(
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            builder: (context, _, value) =>
                                                RadialGaugeLabel(
                                                  labelProvider:
                                                  const GaugeLabelProvider.value(
                                                      fractionDigits: 1),
                                                  style: const TextStyle(
                                                    color: Color(0xFFDE5044),
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  value: value,
                                                ),
                                            value: 20.5,
                                            radius: 70,
                                            // Chỉnh độ to nhỏ của gauge
                                            curve: Curves.elasticOut,
                                            axis: const GaugeAxis(
                                              min: 0,
                                              max: 50,
                                              degrees: 180,
                                              pointer: GaugePointer.triangle(
                                                width: 20,
                                                height: 20,
                                                borderRadius: 20 * 0.125,
                                                color: Color(0xFFDE5044),
                                                position:
                                                GaugePointerPosition.surface(
                                                  offset: Offset(0, 20 * 0.6),
                                                ),
                                                border: GaugePointerBorder(
                                                  color: Colors.white,
                                                  width: 20 * 0.125,
                                                ),
                                              ),
                                              // progressBar: const GaugeProgressBar.basic(
                                              //   color: Colors.white,
                                              // ),
                                              transformer:
                                              const GaugeAxisTransformer
                                                  .colorFadeIn(
                                                interval: Interval(0.0, 0.3),
                                                background: Color(0xFFD9DEEB),
                                              ),
                                              style: GaugeAxisStyle(
                                                thickness: 20,
                                                background: Colors.grey,
                                                blendColors: false,
                                                cornerRadius:
                                                Radius.circular(0.0),
                                              ),
                                              progressBar: null,
                                              segments: [
                                                const GaugeSegment(
                                                  from: 0,
                                                  to: 18.4,
                                                  color: Color(0xFF32B5EB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 18.5,
                                                  to: 24.9,
                                                  color: Color(0xFFA3B426),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 25.0,
                                                  to: 29.9,
                                                  color: Color(0xFFF7C700),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 30.0,
                                                  to: 34.9,
                                                  color: Color(0xFFE88024),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 35.0,
                                                  to: 50,
                                                  color: Color(0xFFE41B21),
                                                  cornerRadius: Radius.zero,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height *0.02),
                                          Text(
                                            'CÂN ĐỐI',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              color: const Color(0xFFDE5044),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //-----------
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.025),
                child: Text(
                  'Bạn nên uống bao nhiêu nước',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 150,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Bài tập gợi ý hôm nay',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Xem tất cả',
                        textAlign: TextAlign.end,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 150,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
