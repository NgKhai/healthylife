import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/util/color_theme.dart';
import 'package:intl/intl.dart';

class BMIGaugeWidget extends StatefulWidget {
  const BMIGaugeWidget({super.key});

  @override
  State<BMIGaugeWidget> createState() => _BMIGaugeWidgetState();
}

class _BMIGaugeWidgetState extends State<BMIGaugeWidget> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      "Hôm nay",
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),
                        AnimatedRadialGauge(
                          duration: const Duration(milliseconds: 2000),
                          builder: (context, _, value) => RadialGaugeLabel(
                            labelProvider: const GaugeLabelProvider.value(fractionDigits: 1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            value: value,
                          ),
                          value: 20.5,
                          radius: 150,
                          // Chỉnh độ to nhỏ của gauge
                          curve: Curves.elasticOut,
                          axis: GaugeAxis(
                            min: 0,
                            max: 40,
                            degrees: 180,
                            pointer: GaugePointer.triangle(
                              width: 35,
                              height: 35,
                              borderRadius: 35 * 0.125,
                              color: Colors.white,
                              position: GaugePointerPosition.surface(
                                offset: Offset(0, 35 * 0.6),
                              ),
                              border: GaugePointerBorder(
                                color: ColorTheme.darkGreenColor,
                                width: 35 * 0.125,
                              ),
                            ),
                            // progressBar: const GaugeProgressBar.basic(
                            //   color: Colors.white,
                            // ),
                            transformer: GaugeAxisTransformer.colorFadeIn(
                              interval: Interval(0.0, 0.3),
                              background: Color(0xFFD9DEEB),
                            ),
                            style: GaugeAxisStyle(
                              thickness: 35,
                              background: Colors.grey,
                              blendColors: false,
                              cornerRadius: Radius.circular(0.0),
                            ),
                            progressBar: null,
                            segments: [
                               GaugeSegment(
                                from: 0,
                                to: 18.5,
                                color: ColorTheme.gaugeColor1,
                                cornerRadius: Radius.zero,
                              ),
                               GaugeSegment(
                                from: 18.5,
                                to: 25.0,
                                color: ColorTheme.gaugeColor2,
                                cornerRadius: Radius.zero,
                              ),
                               GaugeSegment(
                                from: 25.0,
                                to: 30.0,
                                color: ColorTheme.gaugeColor3,
                                cornerRadius: Radius.zero,
                              ),
                               GaugeSegment(
                                from: 30.0,
                                to: 35.0,
                                color: ColorTheme.gaugeColor4,
                                cornerRadius: Radius.zero,
                              ),
                               GaugeSegment(
                                from: 35.0,
                                to: 40,
                                color: ColorTheme.gaugeColor5,
                                cornerRadius: Radius.zero,
                              ),
                            ],
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
    );
  }
}
