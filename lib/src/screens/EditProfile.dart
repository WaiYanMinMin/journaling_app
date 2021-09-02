
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journaling_app/src/dialogs/confirmation.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
    late File? image;
     Future pickImage()  async {
       final image =await ImagePicker().pickImage(source: ImageSource.gallery);
       if(image==null)return;

       final imageTemp =File(image.path);
       this.image = imageTemp;
      

     }


  ConfirmationDialogs _confirmationDialogs = new ConfirmationDialogs();
  late final firstName;
  late final lastName;
  late final city;
  late final country;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xff2B7279),
      child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 200.0,
                            child: Center(
                              child: Image.asset(
                                'assets/pngs/bg.png',
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 200.0,
                            color: Colors.black45,
                            child: Center(
                                child: Container(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add, size: 30),
                              ),
                            )),
                          ),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      AutoRouter.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: Color(0xff67A9A9),
                                      size: 30,
                                    )),
                                SizedBox(
                                  width: 80,
                                ),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff67A9A9),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 150,
                            left: 150,
                            child: Container(
                                width: 130,
                                height: 100,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset(
                                            'assets/pngs/avatar.png')),
                                    Positioned(
                                      right: 20,
                                      top: 70,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff76DBFB)),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
                                            FontAwesomeIcons.camera,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Positioned(
                              top: 300,
                              left: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "First Name",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText: 'Enter your first name'),
                                        onChanged: (value) {
                                          setState(() {
                                            firstName = value.trim();
                                          });
                                        }),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "Last Name",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText: 'Enter your last name'),
                                        onChanged: (value) {
                                          setState(() {
                                            firstName = value.trim();
                                          });
                                        }),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "Country",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText: 'Enter your country'),
                                        onChanged: (value) {
                                          setState(() {
                                            firstName = value.trim();
                                          });
                                        }),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "City",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText: 'Enter your city'),
                                        onChanged: (value) {
                                          setState(() {
                                            city = value.trim();
                                          });
                                        }),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    margin: new EdgeInsets.only(left: 130),
                                    child: Row(children: [
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            AutoRouter.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff67A9A9)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _confirmationDialogs.confirmation(
                                                "Are You Sure?", context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff67A9A9),
                                          ),
                                          child: Text("Save"),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ))
                        ],
                      ))))),
    ));
  }


}
