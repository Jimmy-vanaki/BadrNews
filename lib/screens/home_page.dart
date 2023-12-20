import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/bookmark_page.dart';
import 'package:badrnews/screens/news_list_page.dart';
import 'package:badrnews/screens/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 1;
  static const List<IconData> iconList = [
    Icons.settings,
    Icons.home_filled,
    Icons.bookmark_border,
  ];
  final List<String> drawerItemText = [
    "الرئيسية",
    "من نحن",
    "اتصل بنا",
    "سياسة الخصوصية",
    "مشاركة التطبيق",
  ];
  final List<IconData> drawerItemIcon = [
    Icons.home,
    Icons.assignment_late_outlined,
    Icons.phone_enabled,
    Icons.privacy_tip_outlined,
    Icons.share,
  ];
  List<Widget> pages() {
    return [
      // ignore: prefer_const_constructors
      SettingPage(),
      // ignore: prefer_const_constructors
      NewsListPag(),
      // ignore: prefer_const_constructors
      BookMarkPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.themeColor,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              './Assets/images/logo-bn.png',
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: IndexedStack(
          index: _bottomNavIndex,
          children: pages(),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 152, 151, 151),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              children: <Widget>[
                Image.asset(
                  './Assets/images/logo-bn.png',
                  fit: BoxFit.fill,
                  width: 180,
                ),
                const SizedBox(height: 100),
                Column(
                  children: List.generate(
                    drawerItemText.length,
                    (index) => DrawerItems(
                      title: drawerItemText[index],
                      icon: drawerItemIcon[index],
                      tag: index,
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "الاصدار: 1.1",
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Jazeera-Regular',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            return Icon(
              iconList[index],
              size: 24,
              color: isActive ? Constants.themeColor : Colors.grey,
            );
          },
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(
            () {
              _bottomNavIndex = index;
            },
          ),
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  final String title;
  final IconData icon;
  final int tag;
  const DrawerItems({
    super.key,
    required this.title,
    required this.icon,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black87,
              size: 25,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontFamily: 'Jazeera-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
