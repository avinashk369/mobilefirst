import 'package:flutter/material.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/utils.dart';
import 'package:mobilefirst/widgets/g_sinin_button.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/logo1.png',
                //   height: 50,
                // ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  appName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style:
                      kLabelStyleBold.copyWith(fontSize: 20, letterSpacing: 2),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/logo.png',
          ),
          const Spacer(),
          Text(
            "Welcome to the world of MobileFirst",
            textAlign: TextAlign.center,
            style: kLabelStyleBold.copyWith(
                color: Colors.deepPurple, fontSize: 18, letterSpacing: 1.8),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: GoogleSignInButton(),
          ),
        ],
      ),
    );
  }
}
