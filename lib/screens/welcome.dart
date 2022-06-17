import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/navigation/nav_bloc.dart';
import 'package:mobilefirst/screens/navbar/demo.dart';
import 'package:mobilefirst/screens/todo/todo_mgmt.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBloc>(
          create: (context) => NavBloc(),
        ),
      ],
      child: Scaffold(
        body: Builder(builder: (context) {
          return Demo(
            navBloc: context.read<NavBloc>(),
          );
        }),
      ),
    );
  }
}
