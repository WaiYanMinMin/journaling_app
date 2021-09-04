import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/routers/router.gr.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int _page = 0;
  var selectedDate = DateTime.now();

  int selectedIndex = 1;
  int selectedIndexWeather = 1;
  File? imageFile;

  ImagePicker _picker = ImagePicker();

  _imgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NoteDao noteDao = Get.find();

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
      backgroundColor: Color(0xFF2b7379),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        color: Color(0xff67A9A9),
        backgroundColor: Color(0xff2B7279),
        items: [
          Icon(
            FontAwesomeIcons.home,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.calendarAlt,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.userAlt,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });

          if (_page == 3) {
            AutoRouter.of(context).replace(ProfileRoute());
          } else if (_page == 2) {
            AutoRouter.of(context).replace(CalendarRoute());
          } else if (_page == 1) {
            AutoRouter.of(context).replace(CreateRoute());
          } else {
            AutoRouter.of(context).replace(HomeRoute());
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.red,
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
                                ? Colors.black
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
                                ? Colors.black
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
                  'Title',
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
                    hintText: 'Enter the title name...',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color(0xFFedd09f),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  'Story',
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
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'What about your today',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.grey[200]),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  Container(
                    width: 80,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF2b7379),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).push(HomeRoute());
                      //print(titlecontroller.text);
                      // Get.back();
                      noteDao.addNote(
                        Note(
                          title: titlecontroller.text,
                          description: descriptioncontroller.text,
                          photo: '',
                          emoji: selectedIndex,
                          weather: selectedIndexWeather,
                          dueDate: _formatDate.toString(),
                        ),
                      );
                      print('Image: $imageFile');
                      refreshAll();
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: 15, left: 10),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFedd09f),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Color(0xFF2b7379),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
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
    });
  }
}
