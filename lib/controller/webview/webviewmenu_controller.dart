import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOption {
  reload,
  listCookies,
  clearCookies,
  addCookie,
  setCookie,
  removeCookie,
}

class WebViewMenu extends StatefulWidget {
  final WebViewController controller;

  const WebViewMenu({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebViewMenuState();
}

class _WebViewMenuState extends State<WebViewMenu> {
  late final WebViewController controller;
  final cookieManager = WebViewCookieManager();

  Future<void> _listCookies(WebViewController controller) async {
    final String cookies = await controller
        .runJavaScriptReturningResult('document.cookie') as String;

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cookies.isNotEmpty ? cookies : 'No cookies'),
      ),
    );
  }

  Future<void> _onAddCookies(WebViewController controller) async {
    await controller.runJavaScript(
        'document.cookie = "PHPSESSID=4oira4g2tg4ok6ie196agfpjcd"');

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_listCookies(controller).toString()),
      ),
    );
  }

  Future<void> _onSetCookie(WebViewController controller) async {
    await cookieManager.setCookie(
      const WebViewCookie(
        name: 'PHPSESSID',
        value: '4oira4g2tg4ok6ie196agfpjcd',
        domain: 'https://allevents.in/',
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_listCookies(controller).toString()),
      ),
    );
  }

  Future<void> _onRemoveCookie(WebViewController controller) async {
    await controller.runJavaScript(
        'document.cookie = "PHPSESSID=4oira4g2tg4ok6ie196agfpjcd"');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_listCookies(controller).toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOption>(
      onSelected: (option) async {
        switch (option) {
          case _MenuOption.reload:
            await widget.controller.reload();
            break;
          case _MenuOption.listCookies:
            await _listCookies(widget.controller);
            break;
          case _MenuOption.clearCookies:
            await cookieManager.clearCookies();
            break;
          case _MenuOption.addCookie:
            await _onAddCookies(widget.controller);
            break;
          case _MenuOption.setCookie:
            await _onSetCookie(widget.controller);
            break;
          case _MenuOption.removeCookie:
            await _onRemoveCookie(widget.controller);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOption>(
          value: _MenuOption.reload,
          child: Text('Reload'),
        ),
        const PopupMenuItem<_MenuOption>(
          value: _MenuOption.listCookies,
          child: Text('List Cookies'),
        ),
        const PopupMenuItem<_MenuOption>(
          value: _MenuOption.addCookie,
          child: Text('Add Cookie'),
        ),
        const PopupMenuItem<_MenuOption>(
          value: _MenuOption.removeCookie,
          child: Text('Remove Cookie'),
        ),
        const PopupMenuItem<_MenuOption>(
          value: _MenuOption.clearCookies,
          child: Text('Clear Cookies'),
        ),
        const PopupMenuItem<_MenuOption>(
          value: _MenuOption.setCookie,
          child: Text('Set Cookie'),
        ),
      ],
    );
  }
}
