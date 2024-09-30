import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions { clearCash, clearCookies }

class PopupMenu extends StatelessWidget {
  PopupMenu({super.key, required this.controller});

  final WebViewController controller;
  final cookiesManager = WebViewCookieManager();

  void _clearCookies(BuildContext context) async {
    final hadCookies = await cookiesManager.clearCookies();
    String message = 'Cookies were deleted';

    if (!hadCookies) {
      message = 'There weren`t cookies!';
    }

    _showMessage(context, message);
  }

  void _clearCash(BuildContext context) async {
    await controller.clearCache();
    _showMessage(context, 'Cash was deleted');
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: MenuOptions.clearCash, child: Text('Clear cash')),
        const PopupMenuItem(
            value: MenuOptions.clearCookies, child: Text('Clear cookies'))
      ],
      onSelected: (value) async {
        switch (value) {
          case MenuOptions.clearCash:
            _clearCash(context);
            break;
          case MenuOptions.clearCookies:
            _clearCookies(context);
            break;
        }
      },
    );
  }
}
