import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/page/fat/fat_page.dart';

import '../../util/color_theme.dart';
import '../../util/fat_gauge_check.dart';

class HomeFatGaugeWidget extends StatefulWidget {
  const HomeFatGaugeWidget({super.key});

  @override
  State<HomeFatGaugeWidget> createState() => _HomeFatGaugeWidgetState();
}

class _HomeFatGaugeWidgetState extends State<HomeFatGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FatPage()));
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
                          value: 22,
                          radius: 70,
                          // Chỉnh độ to nhỏ của gauge
                          curve: Curves.elasticOut,
                          axis: GaugeAxis(
                            min: 0,
                            max: 45,
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
                            segments: FatGaugeCheck("Nữ", 22).fatGagugeSegment(),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height *0.02),
                        Text(
                          'BÌNH THƯỜNG',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: ColorTheme.darkGreenColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
    );
  }
}
