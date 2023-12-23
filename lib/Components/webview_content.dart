import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class LoadContentWebView extends StatefulWidget {
  final String content;
  const LoadContentWebView({
    super.key,
    required this.content,
  });

  @override
  State<LoadContentWebView> createState() => _LoadContentWebViewState();
}

class _LoadContentWebViewState extends State<LoadContentWebView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(widget.content);
    return SizedBox(
      width: size.width,
      child: Html(
        data: """
      <!DOCTYPE html>
        <html dir='rtl'>
          <body>
          <div style='direction: rtl;'>${widget.content}</div>
          </body>
        </html>
      """,
        style: {
          "p": Style(
            lineHeight: LineHeight(1.7),
            textAlign: TextAlign.justify,
            backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            fontFamily: 'Jazeera-Regular',
            fontSize: FontSize(Constants.fontSize),
          ),
        },
      ),
    );
  }
}
