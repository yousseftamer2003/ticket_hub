import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String url;

  const PaymentWebView({super.key, required this.url});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {
            log('HTTP error: $error');
          },
          onWebResourceError: (WebResourceError error) {
            log('Web resource error: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            log('call back Url: ${request.url}');
            if (request.url.startsWith(
                'https://bcknd.ticket-hub.net/user/booking/')) {
              if (request.url.contains('success=true')) {
                Navigator.of(context).pop(false);
              } else {
                Navigator.of(context).pop(true);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob Payment'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
