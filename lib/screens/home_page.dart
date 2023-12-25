import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/about_page.dart';
import 'package:badrnews/screens/privacy_policy_page.dart';
import 'package:badrnews/screens/bookmark_page.dart';
import 'package:badrnews/screens/news_list_page.dart';
import 'package:badrnews/screens/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Icons.email_outlined,
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
          width: 300,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    './Assets/images/hd-bn.jpg',
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: List.generate(
                        drawerItemText.length,
                        (index) => DrawerItems(
                          title: drawerItemText[index],
                          icon: drawerItemIcon[index],
                          tag: index,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 280),
                  Text(
                    "الاصدار: 1.0",
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: Constants.regularFontFamily,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      child: RichText(
                        text: TextSpan(
                          text: 'Powered by ',
                          style: TextStyle(color: Colors.black87),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'DIjlah IT',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => _launchUrl('https://dijlah.org'),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
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

Future<void> _launchUrl(_url) async {
  debugPrint('--------------------------------------------');
  if (!await launchUrl(Uri.parse(_url))) {
    throw Exception('Could not launch $_url');
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
      onTap: () async {
        debugPrint(tag.toString());
        switch (tag) {
          case 0:
            Scaffold.of(context).closeDrawer();
            break;
          case 1:
            Navigator.push(
              context,
              PageTransition(
                child: const AboutPage(),
                type: PageTransitionType.bottomToTop,
              ),
            );
            break;
          case 2:
            final Email email = Email(
              recipients: ['info@bnnews.iq'],
              isHTML: false,
            );
            await FlutterEmailSender.send(email);
            break;
          case 3:
            Navigator.push(
              context,
              PageTransition(
                child: const PrivacyPolicyPage(
                  url: 'https://bnnews.iq/privacy_bnnews.html',
                ),
                type: PageTransitionType.bottomToTop,
              ),
            );
            break;
          case 4:
            final box = context.findRenderObject() as RenderBox?;
            Share.share(
              "أدعوك للاطلاع على تطبيق (${Constants.packageInfo.appName}) وذلك عبر الرابط التالي: \n https://play.google.com/store/apps/details?id=${Constants.packageInfo.packageName}",
              subject: "المشاركة ضمن:",
              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
            );

            break;

          default:
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
                fontFamily: Constants.regularFontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
