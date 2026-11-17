import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaypalCheckoutResult {
  final String? orderId;
  final String? error;
  final bool cancelled;

  const PaypalCheckoutResult.approved(this.orderId)
      : error = null,
        cancelled = false;

  const PaypalCheckoutResult.cancelled()
      : orderId = null,
        error = null,
        cancelled = true;

  const PaypalCheckoutResult.failed(this.error)
      : orderId = null,
        cancelled = false;
}

class PaypalCheckoutView extends StatefulWidget {
  final String orderId;
  final String returnUrl;
  final String cancelUrl;
  final bool sandboxMode;

  const PaypalCheckoutView({
    super.key,
    required this.orderId,
    required this.returnUrl,
    required this.cancelUrl,
    this.sandboxMode = false,
  });

  @override
  State<PaypalCheckoutView> createState() =>
      _PaypalCheckoutViewState();
}

class _PaypalCheckoutViewState extends State<PaypalCheckoutView> {
  InAppWebViewController? webView;

  double progress = 0;

  bool _finished = false;

  Timer? _timeoutTimer;

  Uri get _returnUri => Uri.parse(widget.returnUrl);

  Uri get _cancelUri => Uri.parse(widget.cancelUrl);

  Uri get _approvalUri {
    final host = widget.sandboxMode
        ? 'www.sandbox.paypal.com'
        : 'www.paypal.com';

    return Uri.https(
      host,
      '/checkoutnow',
      {'token': widget.orderId},
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.orderId.trim().isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _finish(
          const PaypalCheckoutResult.failed(
            'Invalid PayPal Order ID.',
          ),
        );
      });

      return;
    }

    _timeoutTimer = Timer(
      const Duration(minutes: 10),
          () {
        _finish(
          const PaypalCheckoutResult.failed(
            'PayPal approval timed out. Please try again.',
          ),
        );
      },
    );
  }

  bool _matchesEndpoint(Uri current, Uri expected) {
    String normalizePath(String path) {
      if (path.length > 1 && path.endsWith('/')) {
        return path.substring(0, path.length - 1);
      }
      return path;
    }

    return current.scheme == expected.scheme &&
        current.host.toLowerCase() ==
            expected.host.toLowerCase() &&
        current.port == expected.port &&
        normalizePath(current.path) ==
            normalizePath(expected.path);
  }

  void _finish(PaypalCheckoutResult result) {
    if (_finished || !mounted) return;

    _finished = true;
    _timeoutTimer?.cancel();

    Navigator.of(context).pop(result);
  }

  Future<NavigationActionPolicy> _handleNavigation(
      InAppWebViewController controller,
      NavigationAction navigationAction,
      ) async
  {
    if (_finished) {
      return NavigationActionPolicy.CANCEL;
    }

    final url = navigationAction.request.url;

    if (url == null) {
      return NavigationActionPolicy.ALLOW;
    }

    // Check cancellation FIRST.
    if (_matchesEndpoint(url, _cancelUri)) {
      _finish(
        const PaypalCheckoutResult.cancelled(),
      );

      return NavigationActionPolicy.CANCEL;
    }

    // Buyer returned from PayPal.
    if (_matchesEndpoint(url, _returnUri)) {
      final returnedOrderId =
          url.queryParameters['token'] ??
              url.queryParameters['orderId'];

      if (returnedOrderId == null ||
          returnedOrderId.isEmpty) {
        _finish(
          const PaypalCheckoutResult.failed(
            'PayPal did not return an Order ID.',
          ),
        );

        return NavigationActionPolicy.CANCEL;
      }

      // Never accept a different order ID from the redirect.
      if (returnedOrderId != widget.orderId) {
        _finish(
          const PaypalCheckoutResult.failed(
            'PayPal returned an unexpected Order ID.',
          ),
        );

        return NavigationActionPolicy.CANCEL;
      }

      // Approval only. No capture happens here.
      _finish(
        PaypalCheckoutResult.approved(returnedOrderId),
      );

      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }


  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Payment'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _finish(
              const PaypalCheckoutResult.cancelled(),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(_approvalUri.toString()),
            ),
            initialSettings: InAppWebViewSettings(
              useShouldOverrideUrlLoading: true,
              javaScriptEnabled: true,
              domStorageEnabled: true,
              thirdPartyCookiesEnabled: true,
              cacheEnabled: true,
            ),
            onWebViewCreated: (controller) {
              webView = controller;
            },
            shouldOverrideUrlLoading: _handleNavigation,
            onProgressChanged: (controller, value) {
              if (!mounted) return;

              setState(() {
                progress = value / 100;
              });
            },
            onReceivedError: (controller, request, error) {
              if (request.isForMainFrame == true) {
                _finish(
                  const PaypalCheckoutResult.failed(
                    'Unable to load PayPal. Please check your internet connection and try again.',
                  ),
                );
              }
            },
          ),
          if (progress < 1)
            Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(
                value: progress,
              ),
            ),
        ],
      ),
    );
  }
}