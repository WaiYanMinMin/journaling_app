import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';

import 'package:journaling_app/src/screens/Profile.dart';
import 'package:journaling_app/src/screens/calendar.dart';
import 'package:journaling_app/src/screens/create.dart';
import 'package:journaling_app/src/screens/detail_screen.dart';

import 'update_story.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  final NoteDao noteDao = Get.find();
  // FontAwesomeIcons.sadCry,
  //     FontAwesomeIcons.angry,
  //     FontAwesomeIcons.smile,
  //     FontAwesomeIcons.sadTear,

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2b7379),
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
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
              Get.off(ProfileScreen());
            } else if (_page == 2) {
              Get.off(CalendarScreen());
            } else if (_page == 1) {
              Get.off(CreateScreen());
            } else {
              Get.off(HomeScreen());
            }
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Enter the name whatever u search',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                  'All Entries',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: MediaQuery.of(context).size.height,
                  child: noteList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noteList() {
    return StreamBuilder<List<Note>>(
      stream: noteDao.getAllNotes(),
      builder: (_, data) {
        if (data.hasData) {
          return ListView.builder(
            itemCount: data.data!.length,
            itemBuilder: (_, positioned) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      title: data.data![positioned].title,
                      description: data.data![positioned].description,
                      selectedEmoji: data.data![positioned].emoji,
                      selectedWeather: data.data![positioned].weather,
                      dueDate: data.data![positioned].dueDate,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 12),
                height: 200,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //color: Color(0xFF2b7379),
                  color: Colors.white10,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Color(0xFFedd09f),
                        ),
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0, left: 10, right: 10),
                              child: Container(
                                //color: Colors.black12,
                                child: Center(
                                  //child: Text(data.data![positioned].title),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Text(
                                      data.data![positioned].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF2b7379),
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  //color: Colors.black12,
                                  child: Container(
                                    width: 33,
                                    height: 33,
                                    decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        getEmoji(data.data![positioned].emoji),
                                        color: Color(0xFF2b7379),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                        height: 130,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 15,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 60,
                                height: 88,
                                //color: Colors.black12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.data![positioned].dueDate
                                          .substring(0, 3),
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFedd09f),
                                      ),
                                    ),
                                    //Long long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar country
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: FaIcon(
                                        getWeather(
                                          data.data![positioned].weather,
                                        ),
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 8),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  data.data![positioned].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Container(
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.start,
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.end,
                              //     children: [
                              //       Icon(
                              //         Icons.date_range_outlined,
                              //         size: 20,
                              //       ),
                              //       SizedBox(width: 8),
                              //       Text(
                              //         data.data![positioned].dueDate,
                              //         style: TextStyle(fontSize: 14),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                width: 60,
                                height: 60,
                                color: Colors.black12,
                                // child: Image.file(
                                //   File(data.data![positioned].photo),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          iconSize: 30,
                          color: Colors.black,
                          onPressed: () {
                            Get.to(UpdateScreen(),
                                arguments: data.data![positioned]);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //     top: 10,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Color(0xFFedd09f),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   height: 200,
                //   width: double.infinity,
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: 15, right: 10, top: 16, bottom: 5),
                //     child: Container(
                //       padding: EdgeInsets.only(right: 10),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Expanded(
                //             child: Text(
                //               data.data![positioned].title,
                //               maxLines: 2,
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xff2b7379),
                //               ),
                //             ),
                //           ),
                //           Row(
                //             children: [
                //               Container(
                //                 width: 30,
                //                 height: 30,
                //                 color: Colors.white60,
                //                 child: Center(
                //                   child: Icon(
                //                     getWeather(data.data![positioned].weather),
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(width: 6),
                //               Container(
                //                 width: 30,
                //                 height: 30,
                //                 color: Colors.white60,
                //                 child: Center(
                //                   child: Icon(
                //                     getEmoji(data.data![positioned].emoji),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   top: 75,
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(20),
                //         bottomRight: Radius.circular(20),
                //       ),
                //       color: Colors.white,
                //     ),
                //     height: 150,
                //     child: Padding(
                //       padding: EdgeInsets.only(right: 10, left: 10, top: 15),
                //       child: Expanded(
                //         child: Column(
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Expanded(
                //                   child: Container(
                //                     width: 230,
                //                     child: Text(
                //                       data.data![positioned].description,
                //                       maxLines: 3,
                //                       overflow: TextOverflow.ellipsis,
                //                       style: TextStyle(
                //                           fontSize: 16, color: Colors.grey),
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 10,
                //                 ),
                //                 Container(
                //                   child: Image.asset(
                //                     'assets/pngs/avatar.png',
                //                     width: 60,
                //                     height: 60,
                //                     fit: BoxFit.fill,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(top: 10),
                //               child: Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Icon(Icons.date_range_outlined),
                //                   SizedBox(
                //                     width: 10,
                //                   ),
                //                   Text(
                //                     data.data![positioned].dueDate
                //                         .substring(0, 10),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ),

            //  ListTile(
            //   title: Text(data.data![positioned].title),
            //   subtitle: Text(data.data![positioned].description),
            // ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}
