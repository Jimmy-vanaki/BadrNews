import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  _GetThemeMod() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Constants.fontSize = pref.getDouble("fontsize") ?? 17;
    });
  }

  @override
  void initState() {
    _GetThemeMod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
