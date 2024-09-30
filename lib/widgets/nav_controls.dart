import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final WebViewController controller;
  final void Function(BuildContext context) returnBack;
  final void Function(BuildContext context) goForward;
  final void Function() reloadPage;

  const NavigationControls(
      {super.key,
      required this.controller,
      required this.returnBack,
      required this.goForward,
      required this.reloadPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              returnBack(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        IconButton(
            onPressed: () {
              goForward(context);
            },
            icon: const Icon(Icons.arrow_forward_ios)),
        IconButton(
            onPressed: reloadPage, icon: const Icon(Icons.replay_outlined))
      ],
    );
  }
}
