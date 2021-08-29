import 'package:auto_route/auto_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journaling_app/src/routers/router.gr.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _page = 0;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 3,
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
        body: MaterialApp(
            home: Container(
          color: Color(0xff2B7279),
          child: Text("Profile"),
        )));
  }
}
