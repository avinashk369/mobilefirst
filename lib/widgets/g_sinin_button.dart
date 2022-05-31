// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobilefirst/routes/route_constants.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/authentication.dart';
import 'package:mobilefirst/utils/preference_utils.dart';
import 'package:mobilefirst/utils/theme_constants.dart';
import 'package:mobilefirst/utils/utils.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 60)),
                backgroundColor: MaterialStateProperty.all(darkColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                elevation: MaterialStateProperty.all(1),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  PreferenceUtils.putString(
                      userName, user.displayName ?? user.email!);

                  Navigator.popAndPushNamed(context, dashBoard);
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 30.0,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: kLabelStyle.copyWith(
                            color: secondaryLight, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
