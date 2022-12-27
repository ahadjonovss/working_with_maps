import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_with_maps/ui/splash_page/splash_page.dart';
import 'package:working_with_maps/view_model/splash_view_model.dart';

void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>SplashViewModel())
    ],

      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
