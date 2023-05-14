import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:journaling_app/src/App.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var selectedDate = DateTime.now();
  int selectedIndex = 1;
  int selectedIndexWeather = 1;
  File? imageFile;

  ImagePicker _picker = ImagePicker();
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }

  _imgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final imageTemp = File(pickedFile.path);
    setState(() {
      this.imageFile = imageTemp;
    });
  }

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  late int primaryColor;
  late int secondaryColor;
  @override
  Widget build(BuildContext context) {
    if (color == 'blue') {
      secondaryColor = 0xff67A9A9;
      primaryColor = 0xff2B7279;
    } else if (color == 'green') {
      secondaryColor = 0xff30db2a;
      primaryColor = 0xff127a2e;
    } else {
      secondaryColor = 0xffc3e02f;
      primaryColor = 0xff607012;
    }
    double? width = 80;
    final NoteDao noteDao = Get.find();
    if (AppLocalizations.of(context)?.language == "English") {
      width = 80;
    } else {
      width = 100;
    }
    String _formatDate = DateFormat.yMMMMEEEEd().format(selectedDate);

    //
    //pikerDate = DateTime.now();
    // String getText() {
    //   // ignore: unnecessary_null_comparison
    //   if (null != selectedDate) {
    //     return '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}';
    //   } else {
    //     return 'Selected Date';
    //   }
    // }

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

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(primaryColor),
        actions: [
          GestureDetector(
            onTap: () {
              //print(titlecontroller.text);
              // Get.back();
              noteDao.addNote(
                Note(
                  title: titlecontroller.text,
                  description: descriptioncontroller.text,
                  photo: imageFile?.path ?? 'null',
                  emoji: selectedIndex,
                  weather: selectedIndexWeather,
                  dueDate: _formatDate.toString(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Story created!!'),
                duration: Duration(seconds: 2),
                backgroundColor: Color(secondaryColor),
              ));
              refreshAll();
            },
            child: Container(
              width: width,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)?.save ?? "Save",
                  style: TextStyle(
                      color: Color(secondaryColor),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Color(primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _imgFromGallery,
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white12,
                  child: imageFile == null
                      ? Center(
                          child: FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                          ),
                        )
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                        ),
                ),
              ),
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
                  //color: Colors.red,
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
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
                child: Text(
                  AppLocalizations.of(context)?.title ?? "Title",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
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
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  AppLocalizations.of(context)?.story ?? "Story",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: TextField(
                  controller: descriptioncontroller,
                  maxLines: 9,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.storyhint ??
                        "Write about your story",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.grey[200]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  void refreshAll() {
    setState(() {
      titlecontroller.clear();
      descriptioncontroller.clear();
      imageFile = null;
    });
  }
}
