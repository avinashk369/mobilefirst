import 'package:flutter/material.dart';
import 'package:mobilefirst/utils/theme_constants.dart';

class LoadingUI extends StatelessWidget {
  const LoadingUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator.adaptive(
          backgroundColor: primaryLight,
          valueColor: AlwaysStoppedAnimation<Color>(greyColor),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
