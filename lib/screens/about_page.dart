import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.themeColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            Image.asset(
              './Assets/images/logo-bn.png',
              fit: BoxFit.cover,
              width: 100,
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          r"وكالة انباء عراقية عامة مسجلة لدى هيئة الاعلام والاتصالات ومعتمدة لدى نقابة الصحفيين العراقيين ، تهتم بأخبار العراق والعالم وتحاول ان تكون في المقدمة من ناحية السبق الخبري والتفرد الموضوعي خدمة للمتلقي وتلبية لرغبة الجمهور في تلقي الاخبار والمعلومات المبوبة، وتشعر الوكالة بالمسؤولية المهنية والاخلاقية في اطار دورها كسلطة رابعة ترى ان حقوق المواطن المادية والمعنوية وتحقيق العدالة فوق كل شيء.",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            height: 2.0,
            fontFamily: Constants.regularFontFamily,
          ),
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
