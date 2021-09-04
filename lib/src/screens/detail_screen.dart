<<<<<<< HEAD

=======
>>>>>>> 5c61a6ec154c91ff31703912a68707b1c3185fd6
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatelessWidget {
  // final NoteDao noteDao = Get.find();
  // Note note = Get.arguments;

  final String title;
  final String description;
  final int selectedEmoji;
  final int selectedWeather;
  final String dueDate;

  DetailScreen(
      {required this.title,
      required this.description,
      required this.selectedEmoji,
      required this.selectedWeather,
      required this.dueDate});

  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2b7379),
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
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Detail Page',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                child: Container(
                  //padding: EdgeInsets.only(top: 5),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.white12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dueDate,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: FaIcon(
                                  getEmoji(selectedEmoji),
                                  size: 20,
                                  color: Color(0xFF2b7379),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: FaIcon(
                                  getWeather(selectedWeather),
                                  color: Color(0xFF2b7379),
                                  size: 20,
                                ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.white12,
                  child: Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xFFedd09f),
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 10, bottom: 10, right: 0),
                child: Container(
                  height: 155,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.white12,
                  child: Text(
                    description,
                    maxLines: 40,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => UpdateScreen(
                    //         updateTitle: title, updateDescription: description),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white30,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
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
