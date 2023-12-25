import 'dart:io';
import 'package:badrnews/api/firebase_api.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/db/badr_database.dart';
import 'package:badrnews/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint('connected');
      await Firebase.initializeApp();
      await FirebaseMessaging.instance.subscribeToTopic("general");
      await FirebaseApi().inintNotifications();
      Constants.connectToInternet = true;
    }
  } on SocketException catch (_) {
    debugPrint('not connected');
    Constants.connectToInternet = false;
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Constants.themeColor),
      ),
      home: const BadrNews(),
    ),
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('onMessage clicked!');
    debugPrint(message.notification?.body);
  });
}

class BadrNews extends StatefulWidget {
  const BadrNews({super.key});

  @override
  State<BadrNews> createState() => _BadrNewsState();
}

class _BadrNewsState extends State<BadrNews> {
  InitializeDB initializeDB = InitializeDB();

  _getContent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Constants.fontSize = pref.getDouble("fontsize") ?? 17;
      Constants.lineHeight = pref.getDouble("lineheight") ?? 1.8;
    });
  }

  @override
  initState() {
    _getContent();
    initializeDB.initDb();
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      Constants.packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
