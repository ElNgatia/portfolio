import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/skin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

const _kHomePage = '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Elvis Ngatia | Portfolio Browser</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: "Segoe UI", Tahoma, Arial, sans-serif; background: #EFF4FB; color: #1A1A1A; }
    .toolbar {
      background: linear-gradient(to bottom, #74B2E0, #2567A5);
      padding: 16px 24px; display: flex; align-items: center; gap: 12px;
    }
    .toolbar-icon {
      width: 40px; height: 40px; background: white; border-radius: 50%;
      display: flex; align-items: center; justify-content: center; font-size: 22px;
    }
    .toolbar-title { color: white; font-size: 18px; font-weight: bold; text-shadow: 0 1px 2px rgba(0,0,0,.3); }
    .toolbar-sub { color: rgba(255,255,255,.85); font-size: 13px; margin-top: 2px; }
    .content { padding: 20px 24px; }
    .section-title {
      font-size: 13px; font-weight: bold; color: #0A246A;
      border-bottom: 1px solid #ADCDEF; padding-bottom: 6px; margin-bottom: 12px; margin-top: 20px;
    }
    .section-title:first-child { margin-top: 0; }
    .links-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 8px; }
    a.link-card {
      display: flex; align-items: center; gap: 8px; padding: 8px 12px;
      background: white; border: 1px solid #ADCDEF; border-radius: 3px;
      text-decoration: none; color: #0057A5; font-size: 12px; transition: background .15s;
    }
    a.link-card:hover { background: #E5F3FF; border-color: #3C9BE0; }
    .tip {
      margin-top: 20px; padding: 10px 14px; background: white;
      border: 1px solid #ADCDEF; border-radius: 3px; font-size: 12px; color: #555; line-height: 1.6;
    }
    .tip strong { color: #0A246A; }
  </style>
</head>
<body>
  <div class="toolbar">
    <div class="toolbar-icon">🌐</div>
    <div>
      <div class="toolbar-title">Elvis Ngatia's Portfolio Browser</div>
      <div class="toolbar-sub">Welcome — type a URL in the address bar or click a link below</div>
    </div>
  </div>
  <div class="content">
    <div class="section-title">Quick Links</div>
    <div class="links-grid">
      <a class="link-card" href="https://pub.dev/publishers/ngatia.dev/packages" target="_blank">📦 pub.dev packages</a>
      <a class="link-card" href="https://github.com/ElNgatia" target="_blank">💻 GitHub</a>
      <a class="link-card" href="https://github.com/Solutech-Limited" target="_blank">🏢 Solutech Engineering</a>
      <a class="link-card" href="https://flutter.dev" target="_blank">🐦 Flutter</a>
      <a class="link-card" href="https://dart.dev" target="_blank">🎯 Dart</a>
    </div>
    <div class="section-title">About This Browser</div>
    <div class="tip">
      <strong>Internet Explorer 7.0 — Windows 7 Edition</strong><br>
      This simulated browser lets you navigate the web from within the portfolio desktop.<br>
      Use the address bar above to type a URL and press <strong>Enter</strong> or click <strong>Go</strong> to navigate.
      Note: Some websites may not load within this embedded browser due to security restrictions.
    </div>
  </div>
</body>
</html>''';

class BrowserWindow extends StatefulWidget {
  const BrowserWindow({super.key});

  @override
  State<BrowserWindow> createState() => _BrowserWindowState();
}

class _BrowserWindowState extends State<BrowserWindow> {
  late final WebViewController _controller;
  final TextEditingController _addressController = TextEditingController(
    text: 'about:home',
  );

  /// True while a programmatic (address-bar/home) load is in flight so the
  /// navigation delegate doesn't treat it as a user-clicked link.
  bool _programmaticLoad = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    // NavigationDelegate is unsupported by webview_flutter_web; on the web
    // the home page's target="_blank" links open real browser tabs instead.
    if (!kIsWeb) {
      _controller.setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (_programmaticLoad) {
              _programmaticLoad = false;
              return NavigationDecision.navigate;
            }
            final url = request.url;
            if (url.startsWith('http://') || url.startsWith('https://')) {
              launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    }
    _controller.loadHtmlString(_kHomePage);
    if (!kIsWeb) {
      // JavaScript is always enabled in the web implementation's iframe;
      // the setter itself throws UnimplementedError there.
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    }
  }

  void _loadHome() {
    _programmaticLoad = true;
    _controller.loadHtmlString(_kHomePage);
    if (mounted) setState(() => _addressController.text = 'about:home');
  }

  void _navigate(String input) {
    String url = input.trim();
    if (url.isEmpty || url == 'about:home') {
      _loadHome();
      return;
    }
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      if (url.contains('.') && !url.contains(' ')) {
        url = 'https://$url';
      } else {
        url = 'https://www.google.com/search?q=${Uri.encodeComponent(url)}';
      }
    }
    _programmaticLoad = true;
    _controller.loadRequest(Uri.parse(url));
    if (mounted) setState(() => _addressController.text = url);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToolbar(),
        Expanded(child: WebViewWidget(controller: _controller)),
        _buildStatusBar(),
      ],
    );
  }

  Widget _buildToolbar() {
    final skin = SkinPalette.of(context);
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: skin.cardHeaderBackground,
        border: Border(bottom: BorderSide(color: skin.divider)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Row(
        children: [
          _NavButton(
            icon: Icons.arrow_back,
            tooltip: 'Back',
            onPressed: () => _controller.goBack(),
          ),
          const SizedBox(width: 2),
          _NavButton(
            icon: Icons.arrow_forward,
            tooltip: 'Forward',
            onPressed: () => _controller.goForward(),
          ),
          const SizedBox(width: 4),
          _NavButton(
            icon: Icons.refresh,
            tooltip: 'Refresh',
            onPressed: () => _controller.reload(),
          ),
          const SizedBox(width: 4),
          _NavButton(
            icon: Icons.home,
            tooltip: 'Home',
            onPressed: _loadHome,
          ),
          const SizedBox(width: 6),
          Expanded(child: _buildAddressBar()),
          const SizedBox(width: 4),
          _GoButton(onPressed: () => _navigate(_addressController.text)),
        ],
      ),
    );
  }

  Widget _buildAddressBar() {
    final skin = SkinPalette.of(context);
    return Container(
      height: 26,
      decoration: BoxDecoration(
        color: skin.pageBackground,
        border: Border.all(color: skin.chipBorder),
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: TextField(
        controller: _addressController,
        style: TextStyle(fontSize: 12, color: skin.textPrimary),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
        onSubmitted: _navigate,
      ),
    );
  }

  Widget _buildStatusBar() {
    final skin = SkinPalette.of(context);
    return Container(
      height: 22,
      decoration: BoxDecoration(
        color: skin.chipBackground,
        border: Border(top: BorderSide(color: skin.divider)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Done',
              style: TextStyle(fontSize: 11, color: skin.textTertiary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Icon(Icons.language, size: 12, color: skin.accent),
              const SizedBox(width: 4),
              Text(
                'Internet Explorer',
                style: TextStyle(fontSize: 11, color: skin.accent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(3),
        child: SizedBox(
          width: 26,
          height: 26,
          child: Icon(
            icon,
            size: 16,
            color: onPressed != null ? skin.textTertiary : skin.iconDisabled,
          ),
        ),
      ),
    );
  }
}

class _GoButton extends StatefulWidget {
  const _GoButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_GoButton> createState() => _GoButtonState();
}

class _GoButtonState extends State<_GoButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final skin = SkinPalette.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _hovered
                    ? [skin.hoverBackground, skin.hoverBackground]
                    : [skin.buttonTop, skin.buttonBottom],
              ),
              border: Border.all(
                color: _hovered ? skin.accent : skin.buttonBorder,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: _hovered ? skin.accent : skin.textTertiary,
                ),
              const SizedBox(width: 2),
              Text(
                'Go',
                style: TextStyle(
                  fontSize: 11,
                  color: _hovered ? skin.accent : skin.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
