import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';

import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

import 'package:journaling_app/src/widgets/language_picker_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
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
      secondaryColor = 0xffc3e02f;
      primaryColor = 0xff607012;
    }
    final ProfileDao profileDao = Get.find();

    return Scaffold(
        body: StreamBuilder<Profile?>(
            stream: profileDao.getProfiledata(),
            builder: (_, data) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // background image and bottom contents
                  Column(
                    children: <Widget>[
                      Container(
                        color: Color(secondaryColor),
                        height: 200.0,
                        child: Center(
                          child: data.hasData
                              ? Image.file(
                                  File(data.data!.bgImage),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset("assets/pngs/bgnull.png"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Color(primaryColor),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  margin: new EdgeInsets.only(left: 20),
                                  width: double.infinity,
                                  child: Text(
                                    AppLocalizations.of(context)?.settings ??
                                        "Settings",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin:
                                      new EdgeInsets.only(left: 20, top: 30),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.globe,
                                        color: Colors.white,
                                      ),
                                      Container(
                                          margin: new EdgeInsets.only(left: 10),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.languages ??
                                                  "Languages",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Container(
                                        margin: (() {
                                          if (AppLocalizations.of(context)
                                                  ?.language ==
                                              "English") {
                                            return new EdgeInsets.only(
                                                left: 99);
                                          } else {
                                            return new EdgeInsets.only(
                                                left: 30);
                                          }
                                        }()),
                                        width: 100,
                                        height: 50,
                                        child: LanguagePickerWidget(),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      new EdgeInsets.only(left: 20, top: 30),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: new EdgeInsets.only(left: 10),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.themecolor ??
                                                  "Change theme",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Container(
                                        margin: (() {
                                          if (AppLocalizations.of(context)
                                                  ?.language ==
                                              "English") {
                                            return new EdgeInsets.only(
                                                left: 20);
                                          } else {
                                            return new EdgeInsets.only(
                                                left: 30);
                                          }
                                        }()),
                                        width: 180,
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Theme(
                                              data: ThemeData(
                                                  unselectedWidgetColor:
                                                      Color(0xff67A9A9)),
                                              child: Radio(
                                                  activeColor:
                                                      Color(secondaryColor),
                                                  value: "blue",
                                                  groupValue: color,
                                                  onChanged: (value) {
                                                    color = value.toString();
                                                    setState(() {});
                                                    final provider = Provider
                                                        .of<LocaleProvider>(
                                                            context,
                                                            listen: false);
                                                    provider.setcolor(
                                                        color ?? 'blue');
                                                  }),
                                            ),
                                            Theme(
                                              data: ThemeData(
                                                  unselectedWidgetColor:
                                                      Color(0xffc3e02f)),
                                              child: Radio(
                                                  activeColor:
                                                      Color(secondaryColor),
                                                  value: "yellow",
                                                  groupValue: color,
                                                  onChanged: (value) {
                                                    color = value.toString();
                                                    setState(() {});
                                                    final provider = Provider
                                                        .of<LocaleProvider>(
                                                            context,
                                                            listen: false);
                                                    provider.setcolor(
                                                        color ?? 'blue');
                                                  }),
                                            ),
                                            Theme(
                                              data: ThemeData(
                                                  unselectedWidgetColor:
                                                      Color(0xff30db2a)),
                                              child: Radio(
                                                  activeColor:
                                                      Color(secondaryColor),
                                                  value: "green",
                                                  groupValue: color,
                                                  onChanged: (value) {
                                                    color = value.toString();
                                                    final provider = Provider
                                                        .of<LocaleProvider>(
                                                            context,
                                                            listen: false);
                                                    provider.setcolor(
                                                        color ?? 'blue');
                                                    setState(() {});
                                                  }),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              );
            }));
  }
}
