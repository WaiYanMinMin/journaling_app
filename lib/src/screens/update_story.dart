import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/screens/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

class UpdateScreen extends StatefulWidget {
  final String title;
  final int id;
  final String description;
  final String photo;
  final String dueDate;
  final int emoji;
  final int weather;

  UpdateScreen(
      {required this.title,
      required this.id,
      required this.description,
      required this.photo,
      required this.dueDate,
      required this.emoji,
      required this.weather});

  @override
  _UpdateScreenState createState() => _UpdateScreenState(
      title: title,
      id: id,
      description: description,
      photo: photo,
      dueDate: dueDate,
      emoji: emoji,
      weather: weather);
}

class _UpdateScreenState extends State<UpdateScreen> {
  final String title;
  final int id;
  final String description;
  final String photo;
  final String dueDate;
  final int emoji;
  final int weather;
  late int selectedIndex;
  late int selectedIndexWeather;
  late TextEditingController titlecontroller = TextEditingController();
  late TextEditingController descriptioncontroller = TextEditingController();
  late File? imageFile;
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }
  _UpdateScreenState(
      {required this.title,
      required this.id,
      required this.description,
      required this.photo,
      required this.dueDate,
      required this.emoji,
      required this.weather}) {
    imageFile = File(photo);
    titlecontroller.text = title;
    descriptioncontroller.text = description;
    selectedIndex = emoji;
    selectedIndexWeather = weather;
  }

  ImagePicker _picker = ImagePicker();
  final NoteDao noteDao = Get.find();

  IconData getEmoji(int? selectIndex) {
    if (selectIndex == 0) {
      return FontAwesomeIcons.sadCry;
    } else if (selectIndex == 1) {
      return FontAwesomeIcons.angry;
    } else if (selectIndex == 2) {
      return FontAwesomeIcons.smile;
    } else {
      return FontAwesomeIcons.sadTear;
    }
  }

  IconData getWeather(int? selectedWeather) {
    if (selectedWeather == 0) {
      return FontAwesomeIcons.cloudRain;
    } else if (selectedWeather == 1) {
      return FontAwesomeIcons.sun;
    } else if (selectedWeather == 2) {
      return FontAwesomeIcons.snowflake;
    } else {
      return FontAwesomeIcons.cloudSun;
    }
    // FontAwesomeIcons.cloudRain,
    //   FontAwesomeIcons.sun,
    //   FontAwesomeIcons.snowflake,
    //   FontAwesomeIcons.cloudSun,
  }

  Future _imgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final imageTemp = File(pickedFile.path);
    setState(() {
      imageFile = imageTemp;
    });
  }

  var selectedDate = DateTime.now();
  Future datePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int primaryColor;
    int secondaryColor;
    if (color == 'blue') {
      secondaryColor = 0xff67A9A9;
      primaryColor = 0xff2B7279;
    } else if (color == 'green') {
      secondaryColor = 0xff30db2a;
      primaryColor = 0xff127a2e;
    } else {
      primaryColor = 0xffc3e02f;
      secondaryColor = 0xff607012;
    }
    double? width = 80;
    List<IconData> emoList = [
      FontAwesomeIcons.sadCry,
      FontAwesomeIcons.angry,
      FontAwesomeIcons.smile,
      FontAwesomeIcons.sadTear,
    ];
    List<IconData> weatherList = [
      FontAwesomeIcons.cloudRain,
      FontAwesomeIcons.sun,
      FontAwesomeIcons.snowflake,
      FontAwesomeIcons.cloudSun,
    ];
    String _formatDate = DateFormat.yMMMMEEEEd().format(selectedDate);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(primaryColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Container(
                  height: 70,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Center(
                        child: Text(
                          'Edit your story',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //App Bar
              Container(
                color: Color(secondaryColor),
                child: InkWell(
                  onTap: () {
                    datePicker(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatDate,
                        //getText(), // '${selectedDate.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ), //date
              SizedBox(height: 10),
              GestureDetector(
                  onTap: _imgFromGallery,
                  child: Stack(children: [
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white12,
                      child:(imageFile?.path!='null')? Image.file(
                        imageFile!,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ):Center()
                    ),
                    Container(
                      height: 180.0,
                      color: Colors.black45,
                      child: Center(
                          child: Container(
                              color: Colors.transparent,
                              child: FaIcon(FontAwesomeIcons.camera))),
                    )
                  ])),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, left: 0),
                child: Container(
                  height: 60,
                  //color: Colors.red,
                  width: MediaQuery.of(context).size.width,

                  //padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: emoList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          print("index :" + selectedIndex.toString());
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black12,
                        ),
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: FaIcon(
                            emoList[index],
                            color: selectedIndex == index
                                ? Color(secondaryColor)
                                : Colors.white24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, left: 0),
                child: Container(
                  height: 60,

                  width: MediaQuery.of(context).size.width,

                  //padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: emoList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndexWeather = index;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: selectedIndexWeather == index
                              ? Colors.white
                              : Colors.black12,
                        ),
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: FaIcon(
                            weatherList[index],
                            color: selectedIndexWeather == index
                                ? Color(secondaryColor)
                                : Colors.white24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ), //weather and emoji
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    AppLocalizations.of(context)?.title ?? "Title",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.titlehint ??
                        "Enter the title name",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffCECECE), width: 2.0),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    titlecontroller.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ), //title
              Container(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    AppLocalizations.of(context)?.story ?? "Story",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: TextField(
                  controller: descriptioncontroller,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.storyhint ??
                        "Write about your story",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffCECECE), width: 2.0),
                        borderRadius: BorderRadius.circular(7.0)),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    descriptioncontroller.text = value;
                  },
                ),
              ), //Story
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: width,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)?.cancel ?? "Back",
                          style: TextStyle(
                            color: Color(primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.close(2);

                      noteDao.updateNote(
                        Note(
                          id: id,
                          title: titlecontroller.text,
                          description: descriptioncontroller.text,
                          photo: imageFile?.path ?? 'null',
                          emoji: selectedIndex,
                          weather: selectedIndexWeather,
                          dueDate: _formatDate,
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      margin: EdgeInsets.only(right: 15, left: 10),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(secondaryColor),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)?.save ?? "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
