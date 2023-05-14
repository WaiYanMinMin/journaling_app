import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:journaling_app/l10n/l10n.dart';
import 'package:journaling_app/src/App.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/onboardingscreens/onboardingscreen.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'database/note_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserSimplePreferences.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? color;
  @override
  void initState() {
    super.initState();

    color = UserSimplePreferences.getColor();
  }

  @override
  Widget build(BuildContext context) {
    String image = "assets/pngs/logologoblue.png";
    if (color == 'blue') {
      image = "assets/pngs/logologoblue.png";
    } else if (color == 'green') {
      image = "assets/pngs/logogreen.png";
    } else {
      image = "assets/pngs/logoyellow.png";
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
          image,
        ),
        splashIconSize: 300,
        backgroundColor: Colors.white,
        nextScreen: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool? _isFirstRun;
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
    });
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
    _checkFirstRun();

    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          late final provider = Provider.of<LocaleProvider>(context);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder<NoteDatabase>(
              future: $FloorNoteDatabase.databaseBuilder('note.db').build(),
              builder: (context, data) {
                if (data.hasData) {
                  Get.put(data.data!.noteDao);
                  Get.put(data.data!.profileDao);
                  Get.put(data.data!.eventDao);
                  if (_isFirstRun == true) {
                    return StartScreen();
                  }
                  return MyApp();
                } else if (data.hasError) {
                  return Text('${data.error}');
                } else {
                  return Scaffold(
                      backgroundColor: Colors.white, body: Center());
                }
              },
            ),
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        });
  }
}
