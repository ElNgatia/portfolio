import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// IE / Windows 7 palette
const _kIEToolbarBg = Color(0xFFECF3FC);
const _kIEToolbarBorder = Color(0xFFC5D5E8);
const _kIEBlue = Color(0xFF0057A5);
const _kStatusBarBg = Color(0xFFEFF4FB);

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
      <a class="link-card" href="https://pub.dev/publishers/ngatia.dev/packages" target="_top">📦 pub.dev packages</a>
      <a class="link-card" href="https://github.com/ElNgatia" target="_top">💻 GitHub</a>
      <a class="link-card" href="https://flutter.dev" target="_top">🐦 Flutter</a>
      <a class="link-card" href="https://dart.dev" target="_top">🎯 Dart</a>
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

  bool _isLoading = false;
  int _loadingProgress = 0;
  bool _canGoBack = false;
  bool _canGoForward = false;
  String _statusText = 'Done';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (!mounted) return;
            setState(() {
              _loadingProgress = progress;
              _isLoading = progress < 100;
              _statusText =
                  _isLoading ? 'Loading ($progress%)...' : 'Done';
            });
            _updateNavState();
          },
          onPageStarted: (url) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _statusText = 'Connecting...';
            });
          },
          onPageFinished: (url) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _statusText = 'Done';
            });
            _updateNavState();
          },
          onUrlChange: (change) {
            if (!mounted) return;
            final url = change.url ?? '';
            setState(() {
              _addressController.text = url.isEmpty ? 'about:home' : url;
            });
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _statusText = 'Error: ${error.description}';
            });
          },
        ),
      )
      ..loadHtmlString(_kHomePage);
  }

  Future<void> _updateNavState() async {
    final canGoBack = await _controller.canGoBack();
    final canGoForward = await _controller.canGoForward();
    if (!mounted) return;
    setState(() {
      _canGoBack = canGoBack;
      _canGoForward = canGoForward;
    });
  }

  void _navigate(String input) {
    String url = input.trim();
    if (url.isEmpty || url == 'about:home') {
      _controller.loadHtmlString(_kHomePage);
      if (mounted) setState(() => _addressController.text = 'about:home');
      return;
    }
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      if (url.contains('.') && !url.contains(' ')) {
        url = 'https://$url';
      } else {
        url = 'https://www.google.com/search?q=${Uri.encodeComponent(url)}';
      }
    }
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
        if (_isLoading)
          LinearProgressIndicator(
            value: _loadingProgress / 100,
            backgroundColor: _kIEToolbarBg,
            valueColor: const AlwaysStoppedAnimation<Color>(_kIEBlue),
            minHeight: 3,
          ),
        Expanded(child: WebViewWidget(controller: _controller)),
        _buildStatusBar(),
      ],
    );
  }

  Widget _buildToolbar() {
    return Container(
      height: 38,
      decoration: const BoxDecoration(
        color: _kIEToolbarBg,
        border: Border(bottom: BorderSide(color: _kIEToolbarBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Row(
        children: [
          _NavButton(
            icon: Icons.arrow_back,
            tooltip: 'Back',
            onPressed: _canGoBack ? () => _controller.goBack() : null,
          ),
          const SizedBox(width: 2),
          _NavButton(
            icon: Icons.arrow_forward,
            tooltip: 'Forward',
            onPressed: _canGoForward ? () => _controller.goForward() : null,
          ),
          const SizedBox(width: 4),
          _NavButton(
            icon: _isLoading ? Icons.close : Icons.refresh,
            tooltip: _isLoading ? 'Stop' : 'Refresh',
            onPressed: _isLoading
                ? () => _controller.runJavaScript('window.stop()')
                : () => _controller.reload(),
          ),
          const SizedBox(width: 4),
          _NavButton(
            icon: Icons.home,
            tooltip: 'Home',
            onPressed: () {
              _controller.loadHtmlString(_kHomePage);
              setState(() => _addressController.text = 'about:home');
            },
          ),
          const SizedBox(width: 6),
          Expanded(child: _buildAddressBar()),
          const SizedBox(width: 4),
          _IEGoButton(onPressed: () => _navigate(_addressController.text)),
        ],
      ),
    );
  }

  Widget _buildAddressBar() {
    return Container(
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kIEToolbarBorder),
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _addressController,
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onSubmitted: _navigate,
            ),
          ),
          if (_isLoading)
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 1.5),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 22,
      decoration: const BoxDecoration(
        color: _kStatusBarBg,
        border: Border(top: BorderSide(color: _kIEToolbarBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _statusText,
              style: const TextStyle(fontSize: 11, color: Color(0xFF444444)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Row(
            children: [
              Icon(Icons.language, size: 12, color: _kIEBlue),
              SizedBox(width: 4),
              Text(
                'Internet Explorer',
                style: TextStyle(fontSize: 11, color: _kIEBlue),
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
            color: onPressed != null
                ? const Color(0xFF444444)
                : const Color(0xFFBBBBBB),
          ),
        ),
      ),
    );
  }
}

class _IEGoButton extends StatefulWidget {
  const _IEGoButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_IEGoButton> createState() => _IEGoButtonState();
}

class _IEGoButtonState extends State<_IEGoButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
                  ? [const Color(0xFFE5F3FF), const Color(0xFFCCE4FF)]
                  : [const Color(0xFFF5F5F5), const Color(0xFFDCDCDC)],
            ),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF3C9BE0)
                  : const Color(0xFFADADAD),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_forward,
                size: 12,
                color: _hovered ? _kIEBlue : const Color(0xFF444444),
              ),
              const SizedBox(width: 2),
              Text(
                'Go',
                style: TextStyle(
                  fontSize: 11,
                  color: _hovered ? _kIEBlue : const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
