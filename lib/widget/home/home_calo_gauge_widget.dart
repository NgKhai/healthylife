import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/util/color_theme.dart';

import '../../page/calo/calo_page.dart';

class HomeCaloGaugeWidget extends StatefulWidget {
  const HomeCaloGaugeWidget({super.key});

  @override
  State<HomeCaloGaugeWidget> createState() => _HomeCaloGaugeWidgetState();
}

class _HomeCaloGaugeWidgetState extends State<HomeCaloGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CaloPage()));
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
            color: ColorTheme.darkGreenColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '110',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'Đã nạp',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Text(
                            'Cần nạp',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height:
                            MediaQuery.sizeOf(context).height *
                                0.01,
                          ),
                          AnimatedRadialGauge(
                            duration:
                            const Duration(milliseconds: 2000),
                            builder: (context, _, value) =>
                                RadialGaugeLabel(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  value: 1500 - value,
                                ),
                            value: 110,
                            radius: 60,
                            // Chỉnh độ to nhỏ của gauge
                            curve: Curves.elasticOut,
                            axis: const GaugeAxis(
                              min: 0,
                              max: 1500,
                              degrees: 360,
                              pointer: null,
                              progressBar:
                              GaugeProgressBar.basic(
                                color: Colors.white,
                              ),
                              transformer: GaugeAxisTransformer
                                  .colorFadeIn(
                                interval: Interval(0.0, 0.3),
                                background: Color(0xFFD9DEEB),
                              ),
                              style: GaugeAxisStyle(
                                thickness: 15,
                                background: Colors.grey,
                                blendColors: false,
                                cornerRadius: Radius.circular(0.0),
                              ),
                              // segments: _controller.segments
                              //     .map((e) => e.copyWith(
                              //     cornerRadius:
                              //     Radius.circular(_controller.segmentsRadius)))
                              //     .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'Tiêu hao',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
