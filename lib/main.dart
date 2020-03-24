import 'package:flutter/material.dart';
import 'package:flutter_img_cp/providers/images_provider.dart';
import 'package:flutter_img_cp/screens/config_screen.dart';
import 'package:flutter_img_cp/screens/home_screen.dart';
import 'package:flutter_img_cp/screens/start_screen.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return ChangeNotifierProvider.value(
        value: ImagesProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: StartScreen.routeName,
          routes: <String, Widget Function(BuildContext)>{
            StartScreen.routeName : (BuildContext context) => StartScreen(),
            HomeScreen.routeName : (BuildContext context) => HomeScreen(),
            ConfigScreen.routeName : (BuildContext context) => ConfigScreen()
          },
        ),
      );
  }
}

