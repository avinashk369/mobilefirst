import 'package:flutter/material.dart';
import 'package:mobilefirst/screens/navigation.demo.dart';
import 'package:mobilefirst/screens/user_login.dart';
import 'package:mobilefirst/utils/preference_utils.dart';
import 'package:mobilefirst/utils/utils.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late String name;
  @override
  void initState() {
    name = PreferenceUtils.getString(userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (name.isNotEmpty)
          ? const NavigationDemo() //FireCrud() //Dashboard()
          : const UserLogin(),
    );
  }
}
