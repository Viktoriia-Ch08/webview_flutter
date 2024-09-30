import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_app/widgets/nav_controls.dart';
import 'package:webview_flutter_app/widgets/popup.dart';
import 'package:webview_flutter_app/widgets/webview.dart';

const homePage = 'https://flutter.dev';

class MyWebviewScreen extends StatefulWidget {
  const MyWebviewScreen({super.key});

  @override
  State<MyWebviewScreen> createState() => _MyWebviewScreenState();
}

class _MyWebviewScreenState extends State<MyWebviewScreen> {
  late WebViewController _webViewController;
  int progressIndicator = 0;

  @override
  void initState() {
    _webViewController = WebViewController()..loadRequest(Uri.parse(homePage));
    super.initState();
  }

  void _returnBack(BuildContext context) async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
    } else {
      _showMessage(context, 'No forward history item');
      return;
    }
  }

  void _goForward(BuildContext context) async {
    if (await _webViewController.canGoForward()) {
      _webViewController.goForward();
    } else {
      _showMessage(context, 'No forward history item');
      return;
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    return;
  }

  void _reloadPage() async {
    await _webViewController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('WebPage'),
        actions: [
          NavigationControls(
            controller: _webViewController,
            reloadPage: _reloadPage,
            goForward: _goForward,
            returnBack: _returnBack,
          ),
          PopupMenu(
            controller: _webViewController,
          )
        ],
      ),
      body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) => _returnBack(context),
          child: Webview(
            controller: _webViewController,
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.tv_outlined),
          onPressed: () {
            _webViewController
                .loadRequest(Uri.parse('https://www.youtube.com/'));
          }),
    );
  }
}
