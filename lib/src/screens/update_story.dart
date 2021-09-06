// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:journaling_app/database/data.dart';
// import 'package:journaling_app/database/notedao.dart';
// import 'package:journaling_app/src/screens/home.dart';

// class UpdateScreentwo extends StatefulWidget {
//   final String title;
//   final int id;
//   final String description;
//   final String photo;
//   final String dueDate;
//   int emoji;
//   int weather;

//   UpdateScreentwo(
//       {required this.title,
//       required this.id,
//       required this.description,
//       required this.photo,
//       required this.dueDate,
//       required this.emoji,
//       required this.weather});

//   @override
//   _UpdateScreenState createState() => _UpdateScreenState();
// }

// class _UpdateScreenState extends State<UpdateScreentwo> {
//   final NoteDao noteDao = Get.find();
//   File? imageFile;
//   var selectedDate = DateTime.now();

//   int selectedIndex = 1;
//   int selectedIndexWeather = 1;

//   ImagePicker _picker = ImagePicker();

//   _imgFromGallery() async {
//     XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile == null) return;

//     final imageTemp = File(pickedFile.path);
//     setState(() {
//       this.imageFile = imageTemp;
//     });
//   }

//   List<IconData> emoList = [
//     FontAwesomeIcons.sadCry,
//     FontAwesomeIcons.angry,
//     FontAwesomeIcons.smile,
//     FontAwesomeIcons.sadTear,
//   ];
//   List<IconData> weatherList = [
//     FontAwesomeIcons.cloudRain,
//     FontAwesomeIcons.sun,
//     FontAwesomeIcons.snowflake,
//     FontAwesomeIcons.cloudSun,
//   ];

//   IconData getEmoji(int? selectIndex) {
//     if (selectIndex == 0) {
//       return FontAwesomeIcons.sadCry;
//     } else if (selectIndex == 1) {
//       return FontAwesomeIcons.angry;
//     } else if (selectIndex == 2) {
//       return FontAwesomeIcons.smile;
//     } else {
//       return FontAwesomeIcons.sadTear;
//     }
//   }

//   IconData getWeather(int? selectedWeather) {
//     if (selectedWeather == 0) {
//       return FontAwesomeIcons.cloudRain;
//     } else if (selectedWeather == 1) {
//       return FontAwesomeIcons.sun;
//     } else if (selectedWeather == 2) {
//       return FontAwesomeIcons.snowflake;
//     } else {
//       return FontAwesomeIcons.cloudSun;
//     }
//     // FontAwesomeIcons.cloudRain,
//     //   FontAwesomeIcons.sun,
//     //   FontAwesomeIcons.snowflake,
//     //   FontAwesomeIcons.cloudSun,
//   }

//   @override
//   Widget build(BuildContext context) {
//     String _formatDate = DateFormat.yMMMMEEEEd().format(selectedDate);

//     TextEditingController titlecontroller = TextEditingController();
//     TextEditingController descriptioncontroller = TextEditingController();

//     titlecontroller.text = widget.title;

//     descriptioncontroller.text = widget.description;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xFF2b7379),
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           title: Text('Update Screen'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   color: Colors.red,
//                   child: InkWell(
//                     onTap: () {
//                       datePicker(context);
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           _formatDate,
//                           //getText(), // '${selectedDate.toString()}',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Icon(
//                           Icons.arrow_drop_down_outlined,
//                           color: Colors.white,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                   onTap: _imgFromGallery,
//                   child: Container(
//                     height: 180,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.white12,
//                     child: imageFile == null
//                         ? Center(
//                             child: FaIcon(
//                               FontAwesomeIcons.camera,
//                               color: Colors.white,
//                             ),
//                           )
//                         : Image.file(
//                             File(widget.photo),
//                           ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 0, left: 0),
//                   child: Container(
//                     height: 60,
//                     //color: Colors.red,
//                     width: MediaQuery.of(context).size.width,

//                     //padding: EdgeInsets.symmetric(vertical: 10),
//                     child: ListView.builder(
//                       itemCount: emoList.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (_, index) => GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             widget.emoji = index;
//                           });
//                         },
//                         child: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(13),
//                             color: widget.emoji == index
//                                 ? Colors.white
//                                 : Colors.black12,
//                           ),
//                           margin: EdgeInsets.only(left: 15, right: 15),
//                           child: Center(
//                             child: FaIcon(
//                               emoList[index],
//                               color: widget.emoji == index
//                                   ? Colors.black
//                                   : Colors.white24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 0, left: 0),
//                   child: Container(
//                     height: 60,
//                     //color: Colors.red,
//                     width: MediaQuery.of(context).size.width,

//                     //padding: EdgeInsets.symmetric(vertical: 10),
//                     child: ListView.builder(
//                       itemCount: emoList.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (_, index) => GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             widget.weather = index;
//                           });
//                         },
//                         child: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(13),
//                             color: widget.weather == index
//                                 ? Colors.white
//                                 : Colors.black12,
//                           ),
//                           margin: EdgeInsets.only(left: 15, right: 15),
//                           child: Center(
//                             child: FaIcon(
//                               weatherList[index],
//                               color: widget.weather == index
//                                   ? Colors.black
//                                   : Colors.white24,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, top: 30),
//                   child: Text(
//                     'Title',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 18),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: TextField(
//                     controller: titlecontroller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter the title name...',
//                       hintStyle: TextStyle(
//                         color: Colors.white54,
//                         fontSize: 15,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                     style: TextStyle(
//                       color: Color(0xFFedd09f),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, top: 20),
//                   child: Text(
//                     'Story',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 18),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 15),
//                   child: TextField(
//                     controller: descriptioncontroller,
//                     maxLines: 10,
//                     decoration: InputDecoration(
//                       hintText: 'What about your today',
//                       hintStyle: TextStyle(
//                         color: Colors.white54,
//                         fontSize: 15,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                     style: TextStyle(color: Colors.grey[200]),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Spacer(),
//                     Container(
//                       width: 80,
//                       padding: EdgeInsets.all(15.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(
//                             color: Color(0xFF2b7379),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => HomeScreen(),
//                           ),
//                         );
//                         noteDao.updateNote(
//                           Note(
//                               title: titlecontroller.text,
//                               description: widget.description,
//                               photo: widget.photo,
//                               emoji: widget.emoji,
//                               weather: widget.weather,
//                               dueDate: widget.dueDate),
//                         );
//                       },
//                       child: Container(
//                         width: 80,
//                         margin: EdgeInsets.only(right: 15, left: 10),
//                         padding: EdgeInsets.all(15.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color(0xFFedd09f),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Update',
//                             style: TextStyle(
//                                 color: Color(0xFF2b7379),
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future datePicker(BuildContext context) async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(DateTime.now().year - 5),
//       lastDate: DateTime(DateTime.now().year + 5),
//     );

//     if (date != null && date != selectedDate) {
//       setState(() {
//         selectedDate = date;
//       });
//     }
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/screens/home.dart';

class UpdateScreen extends StatelessWidget {
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

  //final int id = 1;
  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();

    titlecontroller.text = title;

    descriptioncontroller.text = description;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter title',
                border: OutlineInputBorder(),
              ),
              controller: titlecontroller,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter title',
                border: OutlineInputBorder(),
              ),
              controller: descriptioncontroller,
            ),
            Icon(getEmoji(emoji)),
            Icon(getWeather(weather)),
            Text(dueDate),
            Image.file(
              File(photo),
              width: 150,
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(),
                  ),
                );
                noteDao.updateNote(
                  Note(
                      title: titlecontroller.text,
                      description: descriptioncontroller.text,
                      photo: photo,
                      emoji: emoji,
                      weather: weather,
                      dueDate: dueDate,
                      id: id),
                );
              },
              child: Center(
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}