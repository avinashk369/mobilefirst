import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';
import 'package:mobilefirst/repository/todo_repositoryImpl.dart';
import 'package:mobilefirst/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'blocs/bloc_delegate.dart';
import 'routes/route_constants.dart';
import 'routes/route_generator.dart';
import 'styles/custom_theme.dart';
import 'utils/preference_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceUtils.getInstance();
  Paint.enableDithering = true;
  await dotenv.load(fileName: '.env');

  await Parse().initialize(
    dotenv.env['APP_ID']!,
    dotenv.env['API_URL']!,
    clientKey: dotenv.env['CLIENT_KEY'],
    debug: true,
    autoSendSessionId: true,
    liveQueryUrl: "https://todoappdemo.b4a.io",
  );

  // var firstObject = ParseObject('FirstClass')
  //   ..set('message', 'Hey ! First message from Flutter. Parse is now connected')
  //   ..set('key', 'value');
  // await firstObject.save();

  // print('done');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocDelegate(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NewsRepositoryImpl(),
        ),
        RepositoryProvider(create: (context) => TodoRepositoryImpl()),
      ],
      child: MaterialApp(
        title: appName,
        initialRoute: homeRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
      ),
    );
  }
}
