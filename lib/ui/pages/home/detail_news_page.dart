import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNewsPage extends StatelessWidget {
  final String link;

  const DetailNewsPage({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(link));

    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                "assets/ic_arrow_left.png",
                height: 24,
                width: 24,
              ),
            ),
          ),
          Expanded(child: WebViewWidget(controller: webViewController))
        ],
      )),
    );
  }
}
