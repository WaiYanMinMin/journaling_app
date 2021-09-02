import 'package:flutter/material.dart';
import 'package:journaling_app/main.dart';
import 'package:journaling_app/src/routers/router.gr.dart';

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      builder: (context, child) => MaterialApp(
        home: Builder(builder: (context) => MyHome()),
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
