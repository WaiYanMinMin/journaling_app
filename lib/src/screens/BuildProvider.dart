import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:journaling_app/l10n/l10n.dart';
import 'package:journaling_app/src/App.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildProvider extends StatefulWidget {
  @override
  _BuildProviderState createState() => _BuildProviderState();
}

class _BuildProviderState extends State<BuildProvider> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        late final provider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
          title: 'Material App',
          home: MyApp(),
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
