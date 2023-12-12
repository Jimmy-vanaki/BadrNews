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
    // Size size = MediaQuery.of(context).size;
    WebViewController wbController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString("""
      <!DOCTYPE html>
        <html dir='rtl'>
          <head><meta name="viewport" content="width=device-width, initial-scale=0.7"></head>
          <body >
          <p style='direction: rtl;text-align: justify;font-size: 20 !important;font-family: Arial;line-height: 2.2;'>${widget.content}</p>
          <hr>
          <p>${widget.content}</p>
          </body>
        </html>
      """);
    return SizedBox(
      height: 300,
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
