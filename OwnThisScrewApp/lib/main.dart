import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './routes.dart';
import '../screens/pager.dart';
import '../widgets/tts_platform.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Routes.initRoutes();
  runApp(
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MENU',
        home: new MenuHomePage(),
      )
  );
}

class MenuHomePage extends StatelessWidget {

  MenuHomePage(){
    speak("welcome to the smart dispenser app");
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          new MenuPager(),
        ],
      ),
    );
  }
}
