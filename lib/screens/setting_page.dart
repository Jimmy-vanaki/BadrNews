import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isNotifActive = true;

  _SetThemeMod() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble('fontsize', Constants.fontSize);
  }

  @override
  void initState() {
    Constants.fontSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Row(
                children: <Widget>[
                  Icon(
                    Icons.notifications_none,
                    color: Colors.black54,
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "إشعار",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontFamily: 'Jazeera-Regular',
                    ),
                  ),
                ],
              ),
              Switch(
                value: isNotifActive,
                activeColor: Constants.themeColor,
                onChanged: (value) {
                  setState(() {
                    isNotifActive = value;
                  });
                },
              ),
            ],
          ),
          const Divider(),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.share_outlined,
                        color: Colors.black54,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "شارك هذا التطبيق",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontFamily: 'Jazeera-Regular',
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.black54,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Icon(
                      Icons.format_size_rounded,
                      color: Colors.black54,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "حجم الخط",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontFamily: 'Jazeera-Regular',
                      ),
                    ),
                  ],
                ),
                Slider(
                  min: 15,
                  max: 25,
                  value: Constants.fontSize,
                  divisions: 10,
                  label: Constants.fontSize.toInt().toString(),
                  onChanged: (value) {
                    setState(() {
                      Constants.fontSize = value;
                      _SetThemeMod();
                    });
                  },
                  activeColor: Constants.themeColor,
                  inactiveColor: Constants.themeColor.withAlpha(80),
                  thumbColor: Constants.themeColor,
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
