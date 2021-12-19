import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:support_desk/data/depencdencies/injector/injector.dart';
import 'package:support_desk/res/strings/translations.dart';
import 'package:support_desk/res/styles.dart';
import 'package:support_desk/ui/support_desk/support_desk_list_view_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  inject();
  await runMandatoryFutures();

  runApp(SupportDeskApp());
}

class SupportDeskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: SupportDeskStrings(),
      locale: const Locale.fromSubtags(languageCode: "en"),
      debugShowCheckedModeBanner: false,
      theme: Style.appTheme,
      home: SupportDeskScreen(),
    );
  }
}


Future<void> runMandatoryFutures() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
