import 'package:flutter/material.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/theme_constants.dart';
import 'package:mobilefirst/utils/utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.subtitle = false,
    this.preferredSize = const Size.fromHeight(50.0),
  }) : super(key: key);
  final String title;
  final List<Widget>? actions;
  final bool subtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
          subtitle
              ? Text(
                  appName,
                  style: kLabelStyleBold.copyWith(color: greyColor),
                )
              : const SizedBox.shrink(),
        ],
      ),
      centerTitle: false,
      titleSpacing: 8,
      titleTextStyle: kLabelStyleBold.copyWith(fontSize: 18),
      leadingWidth: 45,
      leading: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Image(
          image: AssetImage(
            'assets/images/logo.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
      actions: actions,
    );
  }

  @override
  final Size preferredSize;
}
