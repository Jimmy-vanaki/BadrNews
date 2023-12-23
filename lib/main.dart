import 'package:badrnews/api/firebase_api.dart';
import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/db/badr_database.dart';
import 'package:badrnews/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("general");
  await FirebaseApi().inintNotifications();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BadrNews(),
    ),
  );
}

class BadrNews extends StatefulWidget {
  const BadrNews({super.key});

  @override
  State<BadrNews> createState() => _BadrNewsState();
}

class _BadrNewsState extends State<BadrNews> {
  InitializeDB initializeDB = InitializeDB();

  _GetContent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      Constants.fontSize = pref.getDouble("fontsize") ?? 17;
    });
  }

  @override
  void initState() {
    _GetContent();
    initializeDB.initDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
