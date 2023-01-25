import 'package:ae_clone/controller/webview/webnavigation_control.dart';
import 'package:ae_clone/controller/webview/webviewmenu_controller.dart';
import 'package:ae_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      // ignore: avoid_single_cascade_in_expression_statements
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    // ignore: avoid_single_cascade_in_expression_statements
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Allevents.in"),
        backgroundColor: MyColors.prColor,
        actions: [
          NavigationControls(controller: controller),
          WebViewMenu(controller: controller)
          ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}