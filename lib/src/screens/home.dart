import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? statelocale;

  @override
  void initState() {
    super.initState();
    statelocale = UserSimplePreferences.getLanguage();
  }

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

  TextEditingController? textSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);

    provider.setLocale(Locale(statelocale ?? 'my'));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2b7379),
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
                        controller: textSearchController,
                        onChanged: (value) async {
                          if (value != "") {
                            Provider.of<LocaleProvider>(context, listen: false)
                                .isSearch(true);
                            Future.delayed(Duration(seconds: 1), () {
                              Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .changeString(value);
                            });
                          } else {
                            Provider.of<LocaleProvider>(context, listen: false)
                                .isSearch(false);
                            Future.delayed(Duration(seconds: 1), () {
                              Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .changeString("null");
                            });
                          }
                        },
                        onSubmitted: (value) {
                          if (value == "") {
                            Provider.of<LocaleProvider>(context, listen: false)
                                .isSearch(false);
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: AppLocalizations.of(context)?.searchHint ??
                              "Search by title",
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
                  AppLocalizations.of(context)?.allEntries ?? "All Entries",
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
                  child: (Provider.of<LocaleProvider>(context).searchCheck)
                      ? notesearchList()
                      : noteList(),
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
          print(data.data![0].id.toString());
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: data.data!.length,
            itemBuilder: (_, positioned) => GestureDetector(
              onTap: () {
                Get.to(
                  DetailScreen(
                    id: data.data![positioned].id!,
                    title: data.data![positioned].title,
                    description: data.data![positioned].description,
                    photo: data.data![positioned].photo,
                    selectedEmoji: data.data![positioned].emoji,
                    selectedWeather: data.data![positioned].weather,
                    dueDate: data.data![positioned].dueDate,
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
                          color: Color(0xff67A9A9),
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
                            top: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 88,
                                    //color: Colors.black12,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.data![positioned].dueDate
                                              .substring(0, 3),
                                          style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff67A9A9),
                                          ),
                                        ),
                                        //Long long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar country
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      data.data![positioned].description,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                      width: 60,
                                      height: 60,

                                      //color: Colors.black12,
                                      child: (data.data![positioned].photo !=
                                              'null')
                                          ? Image.file(
                                              File(
                                                  data.data![positioned].photo),
                                              fit: BoxFit.fill,
                                            )
                                          : Center()),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data.data![positioned].dueDate,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }

  Widget notesearchList() {
    return StreamBuilder<List<Note>>(
      stream: noteDao
          .searchData("%" + Provider.of<LocaleProvider>(context).data + "%"),
      builder: (_, data) {
        if (data.hasData) {
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: data.data!.length,
            itemBuilder: (_, positioned) => GestureDetector(
              onTap: () {
                Get.to(
                  DetailScreen(
                    id: data.data![positioned].id!,
                    title: data.data![positioned].title,
                    description: data.data![positioned].description,
                    photo: data.data![positioned].photo,
                    selectedEmoji: data.data![positioned].emoji,
                    selectedWeather: data.data![positioned].weather,
                    dueDate: data.data![positioned].dueDate,
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
                          color: Color(0xff67A9A9),
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
                            top: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 88,
                                    //color: Colors.black12,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.data![positioned].dueDate
                                              .substring(0, 3),
                                          style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff67A9A9),
                                          ),
                                        ),
                                        //Long long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar countryLong long ago ,only have one fool in the Myanmar country
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      data.data![positioned].description,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    //color: Colors.black12,
                                    child: data.hasData
                                        ? Image.file(
                                            File(data.data![positioned].photo),
                                            fit: BoxFit.fill,
                                          )
                                        : Text('Any Photo'),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data.data![positioned].dueDate,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}
