import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class LoadContentWebView extends StatefulWidget {
  final String content;
  final String sw;
  const LoadContentWebView({
    super.key,
    required this.content,
    required this.sw,
  });

  @override
  State<LoadContentWebView> createState() => _LoadContentWebViewState();
}

class _LoadContentWebViewState extends State<LoadContentWebView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String newsText = widget.content;
    debugPrint(Constants.fontSize.toString());
    newsText = newsText.replaceAll("/upload_list/source/Uploads/",
        "http://bnnews.iq/upload_list/source/Uploads/");
    if (widget.sw.isNotEmpty) {
      newsText = newsText.replaceAll(widget.sw,
          ' <span style="background-color: yellow; color: red">${widget.sw}</span>');
    }

    // debugPrint(newsText);
    return SizedBox(
      width: size.width,
      child: Html(
        data: """
      <!DOCTYPE html>
        <html dir='rtl'>
          <body>
          <div style='direction: rtl;'>$newsText</div>
          </body>
        </html>
      """,
        style: {
          "p": Style(
            lineHeight: LineHeight(Constants.lineHeight),
            fontSize: FontSize(Constants.fontSize),
            textAlign: TextAlign.justify,
            fontFamily: Constants.regularFontFamily,
          ),
          "span": Style(
            lineHeight: LineHeight(Constants.lineHeight),
            fontSize: FontSize(Constants.fontSize),
            textAlign: TextAlign.justify,
            fontFamily: Constants.regularFontFamily,
          ),
        },
      ),
    );
  }
}
