import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthylife/util/color_theme.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/CaloHistory.dart';
import '../../model/Exercise.dart';
import '../../model/ExerciseCategory.dart';
import '../../util/snack_bar_error_mess.dart';


class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExerciseState();
}

class _ExerciseState extends State<ExercisePage> {
  int _selectIndex = 0;
  int defaultDuration = 30;

  bool _isLoading = false;

  late List<ExerciseCategory> exerciseCategories = [];
  late List<Exercise> exercises = [];
  late List<bool> _selectStates = [];

  late List<Exercise> filteredExercises = [];

  late List<FoodDetailHistory> foodHistoryList = [];

  late List<ExerciseDetailHistory> exerciseHistoryList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isChecked() {
    return _selectStates.contains(true);
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await getExerciseCategory();
    await getExercise();
    _selectStates = List.generate(exercises.length, (index) => false);

    setState(() {
      _isLoading = false;
    });

    _searchController.clear();

    _selectIndex = 0;
  }

  // hàm lấy dữ liệu loại thức ăn từ firebase
  Future<void> getExerciseCategory() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('ExerciseCategory').get();
    setState(() {
      exerciseCategories = querySnapshot.docs
          .map((doc) => ExerciseCategory.fromFirestore(doc))
          .toList();
    });
  }

  // hàm lấy dữ liệu Food từ firebase
  Future<void> getExercise() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Exercise')
    // .orderBy("FoodName")
        .get();
    setState(() {
      exercises = querySnapshot.docs.map((doc) => Exercise.fromFirestore(doc)).toList();
    });
  }

  Future<void> searchExerciseByName(String name) async {
    setState(() {
      filteredExercises = exercises
          .where((exercise) =>
          exercise.ExerciseName.toLowerCase().contains(name.toLowerCase()))
          .toList();
      _selectStates = List.generate(filteredExercises.length, (index) => false);
    });
  }

  void getExercisesForCategory(String categoryExercise) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Exercise')
        .where('ExerciseCategoryID', isEqualTo: categoryExercise)
        .get();
    setState(() {
      exercises = querySnapshot.docs.map((doc) => Exercise.fromFirestore(doc)).toList();
    });
  }
  Future<void> addExerciseHistory(List<ExerciseDetailHistory> exerciseHistory) async {
    try {

      DateTime now = DateTime.now();
      String dateHistory = DateFormat('dd/MM/yyyy').format(now);

      final exerciseHistoryCollection =
      FirebaseFirestore.instance.collection('CaloHistory');

      final querySnapshot = await exerciseHistoryCollection
          .where('UserID', isEqualTo: 'lCIdlGoR2V2HPOEOFkF9')
          .where('DateHistory', isEqualTo: dateHistory)
          .get();

      if(querySnapshot.docs.isNotEmpty) {
        final document = querySnapshot.docs.first;

        CaloHistory caloHistory = CaloHistory(
            document.id, 'lCIdlGoR2V2HPOEOFkF9', dateHistory, foodHistoryList, exerciseHistoryList);

        final existingExerciseHistory = List<ExerciseDetailHistory>.from(
            document.data()['ExerciseDetailHistory']?.map((e) => ExerciseDetailHistory(
              e['ExerciseID'] ?? '',
              e['Duration'] ?? 0,
            )) ??
                []);
        existingExerciseHistory.addAll(exerciseHistoryList);

        await exerciseHistoryCollection.doc(document.id).update({
          'ExerciseDetailHistory':
          existingExerciseHistory.map((history) => history.toJson()).toList(),
        }).then((value) {
          print("Calo history update\nUID:${caloHistory.CaloHistoryID}");
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CaloPage()));
          Navigator.pop(context);
        }).catchError((error) => print("Failed to update Exercise history: $error"));

      } else {
        final uid = exerciseHistoryCollection.doc().id;

        CaloHistory caloHistory =
        CaloHistory(uid, 'lCIdlGoR2V2HPOEOFkF9', dateHistory, foodHistoryList, exerciseHistory);

        await exerciseHistoryCollection
            .doc(caloHistory.CaloHistoryID)
            .set(caloHistory.toJson())
            .then((value) {
          print("Exercise history Added\nUID:${caloHistory.CaloHistoryID}");
          Navigator.pop(context);
        }).catchError((error) => print("Failed to add Exercise history: $error"));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

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
        title: Text('Bài tập luyện sức khỏe'),
        titleTextStyle: GoogleFonts.getFont(
          'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        backgroundColor: ColorTheme.lightGreenColor,
        bottom: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm...',
                        hintStyle: GoogleFonts.getFont(
                          'Montserrat',
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _searchController.text.isEmpty
                            ? null
                            : IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: _searchController.clear,
                            icon: Icon(CupertinoIcons.clear_circled_solid)),
                      ),
                      onChanged: (value) {
                        // Khi nội dung thanh tìm kiếm thay đổi
                        // Thực hiện hành động tìm kiếm ở đây
                        searchExerciseByName(value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              )),
        ),
      ),
      body: _isLoading
          ? Center(
        child:
        CircularProgressIndicator(), // Show loading indicator while fetching data
      )
          : RefreshIndicator(
        onRefresh: () async => fetchData(),
        child: Container(
          color: Colors.grey.shade100,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          child: Column(
          children: [
          Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: exerciseCategories.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (index == 0) {
                              //  hiển thị tất cả sản phẩm
                              _selectIndex = 0;
                              getExercise();
                            } else {
                              _selectIndex = index;
                              getExercisesForCategory(
                                  exerciseCategories[index - 1].ExerciseCategoryID ??
                                      '');
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height:
                          MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: _selectIndex == index
                                ? Colors.grey.shade50
                                : Colors.white,
                            border: _selectIndex == index
                                ? Border.all(
                                color: Colors.redAccent, width: 3)
                                : null,
                            borderRadius: _selectIndex == index
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              index == 0
                                  ? "Tất cả"
                                  : exerciseCategories[index - 1]
                                  .ExerciseCategoryName ??
                                  "",
                              style: GoogleFonts.getFont('Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: _selectIndex == index
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                          ),

                        ),
                      );
                    }),
              ),
            Expanded(
              child: Stack(
                children: [
                  _searchController.text.isEmpty
                      ? listItem(exercises)
                      : listItem(filteredExercises),
                ],
              ),
            ),
           ],
          ),)
        ),
    );
  }

  Widget listItem(List<Exercise> exercises) {
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(6),
        alignment: Alignment.center,
        child: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  final Uri _url = Uri.parse(exercises[index].ExerciseLink);
                  launchUrl(_url);
                },
                child: Container(
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xFF909090),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.01,
                            vertical: MediaQuery.of(context).size.height * 0.005,
                          ),
                          child: Image.network(
                            fit: BoxFit.cover,
                            exercises[index].ExerciseImage ?? "",
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                        Text(
                          exercises[index].ExerciseName ?? "",
                          style: GoogleFonts.getFont('Montserrat',
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Tiêu hao ${exercises[index].ExerciseCalo} calo",
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                            backgroundColor:
                            ColorTheme.backgroundColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {

                            print('hello');

                            showDialog(
                              context: context,
                              builder: (context) {
                                int duration = defaultDuration;
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      // backgroundColor: ColorTheme.lightGreenColor,
                                      content: Stack(
                                        clipBehavior: Clip.none,
                                        children: <Widget>[
                                          Positioned(
                                            right: -40,
                                            top: -40,
                                            child: InkResponse(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                ColorTheme.lightGreenColor,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.network(
                                                fit: BoxFit.cover,
                                                exercises[index].ExerciseImage ?? "",
                                                errorBuilder: (context, error, stackTrace) =>
                                                const Icon(Icons.image),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                              Text(
                                                exercises[index].ExerciseName ?? "",
                                                style: GoogleFonts.getFont('Montserrat',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "${duration} phút - ${(duration * exercises[index].ExerciseCalo) / defaultDuration} calo",
                                                style: GoogleFonts.getFont(
                                                  'Montserrat',
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                              InputQty.int(
                                                initVal: duration,
                                                minVal: 1,
                                                decoration: const QtyDecorationProps(
                                                    isBordered: false,
                                                    borderShape: BorderShapeBtn.circle,
                                                    width: 50,
                                                    constraints: BoxConstraints()),
                                                onQtyChanged: (val) {
                                                  setState(() {
                                                    duration = val;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(15),
                                                  backgroundColor:
                                                  ColorTheme.backgroundColor,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Thêm ngay',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                onPressed: () {
                                                  exerciseHistoryList.clear();
                                                  exerciseHistoryList.add(ExerciseDetailHistory(exercises[index].ExerciseID, duration));
                                                  addExerciseHistory(exerciseHistoryList);
                                                  SnackBarErrorMess.show(
                                                      context, 'Thêm ${exercises[index].ExerciseName} thành công!');
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Tập ngay',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              );
            }));
  }
}
