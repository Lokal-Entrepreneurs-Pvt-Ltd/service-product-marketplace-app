import 'package:flutter/material.dart';
import 'package:lokal/utils/uik_color.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final dynamic args;

  const WebViewPage({super.key, required this.args});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late String url;
  late String? popLink;
  late String? title;
  late String? lastlink;
  late WebViewController _controller;
  bool _isLoading = true;
  String errorName = "";

  @override
  void initState() {
    super.initState();
    initVariable();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            lastlink = url;
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              errorName = error.description;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (popLink != null &&
                popLink!.isNotEmpty &&
                request.url.startsWith(popLink!)) {
              Navigator.pop(context, lastlink);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void initVariable() {
    url = widget.args["url"] ?? "";
    popLink = widget.args["popLink"] ?? "";
    title = widget.args["title"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        Navigator.pop(context, lastlink);
        return true;
      },
      child: Scaffold(
        appBar: title != null
            ? AppBar(
                title: Text(title!),
              )
            : null,
        body: Stack(
          children: [
            (errorName.isEmpty)
                ? WebViewWidget(controller: _controller)
                : Center(
                    child: Text(
                      errorName,
                      style: TextStyle(
                        color: UikColor.magikarp_500.toColor(),
                      ),
                    ),
                  ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
