import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FatGaugeWidget extends StatefulWidget {
  const FatGaugeWidget({super.key});

  @override
  State<FatGaugeWidget> createState() => _FatGaugeWidgetState();
}

class _FatGaugeWidgetState extends State<FatGaugeWidget> {

  String gender = 'Nữ';
  int age = 22;

  List<GaugeSegment> segments = [];

  List<GaugeSegment> segments_Nam_18_39 = const [
    GaugeSegment(
      from: 0,
      to: 11,
      color: Color(0xFF32B5EB),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 11,
      to: 22,
      color: Color(0xFFA3B426),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 22,
      to: 27,
      color: Color(0xFFF7C700),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 27,
      to: 45,
      color: Color(0xFFE88024),
      cornerRadius: Radius.zero,
    ),
  ];

  List<GaugeSegment> segments_Nam_40_59 = const [
    GaugeSegment(
      from: 0,
      to: 12,
      color: Color(0xFF32B5EB),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 12,
      to: 23,
      color: Color(0xFFA3B426),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 23,
      to: 28,
      color: Color(0xFFF7C700),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 28,
      to: 45,
      color: Color(0xFFE88024),
      cornerRadius: Radius.zero,
    ),
  ];

  List<GaugeSegment> segments_Nam_60 = const [
    GaugeSegment(
      from: 0,
      to: 14,
      color: Color(0xFF32B5EB),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 14,
      to: 25,
      color: Color(0xFFA3B426),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 25,
      to: 30,
      color: Color(0xFFF7C700),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 30,
      to: 45,
      color: Color(0xFFE88024),
      cornerRadius: Radius.zero,
    ),
  ];

  List<GaugeSegment> segments_Nu_18_39 = const [
    GaugeSegment(
      from: 0,
      to: 21,
      color: Color(0xFF32B5EB),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 21,
      to: 35,
      color: Color(0xFFA3B426),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 35,
      to: 40,
      color: Color(0xFFF7C700),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 40,
      to: 45,
      color: Color(0xFFE88024),
      cornerRadius: Radius.zero,
    ),
  ];

  final List<GaugeSegment> segments_Nu_40_59 = const [
    GaugeSegment(
      from: 0,
      to: 22,
      color: Color(0xFF32B5EB),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 22,
      to: 36,
      color: Color(0xFFA3B426),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 36,
      to: 41,
      color: Color(0xFFF7C700),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 41,
      to: 45,
      color: Color(0xFFE88024),
      cornerRadius: Radius.zero,
    ),
  ];

  List<GaugeSegment> segments_Nu_60 = [
    GaugeSegment(
      from: 0,
      to: 23,
      color: Color(0xFF32B5EB),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 23,
      to: 30,
      color: Color(0xFFA3B426),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 30,
      to: 37,
      color: Color(0xFFF7C700),
      cornerRadius: Radius.zero,
    ),
    GaugeSegment(
      from: 37,
      to: 45,
      color: Color(0xFFE88024),
      cornerRadius: Radius.zero,
    ),
  ];

  void checkSegment() {
    if (gender == 'Nam') {
      if (age >= 18 && age <= 39) {
        segments = segments_Nam_18_39;
      } else if (age >= 40 && age <= 59) {
        segments = segments_Nam_40_59;
      } else if (age >= 60) {
        segments = segments_Nam_60;
      }
    } else if (gender == 'Nữ') {
      if (age >= 18 && age <= 39) {
        segments = segments_Nu_18_39;
      } else if (age >= 40 && age <= 59) {
        segments = segments_Nu_40_59;
      } else if (age >= 60) {
        segments = segments_Nu_60;
      }
    }
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSegment();
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
          color: const Color(0xFFDE5044),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            value: value,
                          ),
                          value: 22,
                          radius: 150,
                          // Chỉnh độ to nhỏ của gauge
                          curve: Curves.elasticOut,
                          axis: GaugeAxis(
                            min: 0,
                            max: 45,
                            degrees: 180,
                            pointer: const GaugePointer.triangle(
                              width: 35,
                              height: 35,
                              borderRadius: 35 * 0.125,
                              color: Colors.white,
                              position: GaugePointerPosition.surface(
                                offset: Offset(0, 35 * 0.6),
                              ),
                              border: GaugePointerBorder(
                                color: Color(0xFFDE5044),
                                width: 35 * 0.125,
                              ),
                            ),
                            // progressBar: const GaugeProgressBar.basic(
                            //   color: Colors.white,
                            // ),
                            transformer: const GaugeAxisTransformer.colorFadeIn(
                              interval: Interval(0.0, 0.3),
                              background: Color(0xFFD9DEEB),
                            ),
                            style: const GaugeAxisStyle(
                              thickness: 35,
                              background: Colors.grey,
                              blendColors: false,
                              cornerRadius: Radius.circular(0.0),
                            ),
                            progressBar: null,
                            segments: segments,
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
