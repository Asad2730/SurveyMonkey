import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BIIT Survey Monkey',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ck.x),
          useMaterial3: true,
        ),
        home: const Login());
  }
}
