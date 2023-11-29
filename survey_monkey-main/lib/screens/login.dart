import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/screens/adminHome.dart';
import 'package:survey_monkey/screens/userHome.dart';
import 'package:survey_monkey/widgets/spacers.dart';
import 'package:survey_monkey/widgets/textfields.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: ck.x, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(20),
          margin:const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.graphic_eq,
                size: 50,
                color: Colors.white,
              ),
              gap20(),
              const Text(
                "BIIT SURVEY MONKEY",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              textField("Username", username),
              textField("Password", password),
              gap10(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              gap20(),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const AdminHome());
                },
                child: const Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
