import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    // String str = widget.content.replaceAll('style="font-size: 14.0pt;"', "");
    Size size = MediaQuery.of(context).size;
    WebViewController wbController = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString("""
      <!DOCTYPE html>
        <html dir='rtl'>
          <head><meta name="viewport" content="width=device-width, initial-scale=0.7"></head>
          <body>
              <style>
      @font-face {
        font-family: "Jazeera-Regular";
        src: url("../assets/fonts/Al-Jazeera-Arabic-Regular.ttf") format("truetype");
      }
    </style>
          <div style='direction: rtl;text-align: justify;font-size: ${Constants.fontSize}px !important;font-family: Jazeera-Regular;line-height: 2.2;'>${widget.content}</div>
          <hr>
          <p>${widget.content}</p>
          </body>
        </html>
      """);

    return SizedBox(
      height: 2000,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: WebViewWidget(
          layoutDirection: TextDirection.rtl,
          controller: wbController,
        ),
      ),
    );
  }
}
