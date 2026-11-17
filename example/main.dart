import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const PaypalPaymentDemo());
}

class PaypalPaymentDemo extends StatelessWidget {
  const PaypalPaymentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayPal Payment Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const PaypalDemoScreen(),
    );
  }
}

class PaypalDemoScreen extends StatefulWidget {
  const PaypalDemoScreen({super.key});

  @override
  State<PaypalDemoScreen> createState() => _PaypalDemoScreenState();
}

class _PaypalDemoScreenState extends State<PaypalDemoScreen> {
  bool _loading = false;

  // Replace with your actual backend implementation.
  final PaypalFlowService _paypalService = PaypalFlowService();

  Future<void> _startPaypalCheckout() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      // 1. Create a PayPal order using the current quote on your backend.
      final checkout = await _paypalService.createPaypalOrder();

      if (!mounted) return;

      // 2. Open the PayPal approval page.
      final paypalOrderId = await Navigator.of(context).push<String>(
        MaterialPageRoute(
          builder: (_) => PaypalApprovalPage(
            approvalUrl: checkout.approvalUrl,
          ),
        ),
      );

      if (!mounted || paypalOrderId == null) return;

      // 3. Verify the approved PayPal order on your backend.
      final verifiedOrder =
      await _paypalService.verifyPaypalOrder(paypalOrderId);

      log('Verified PayPal order: $verifiedOrder');

      if (!mounted) return;

      // 4. Continue with your normal quote-order placement flow.
      //
      // Your backend should:
      // - Use the latest server-side quote.
      // - Update the PayPal order amount if necessary.
      // - Capture the PayPal payment.
      // - Create the order.
      //
      // Do not capture the PayPal payment from this example app.
      //
      // await _paypalService.placeQuoteOrder(
      //   paypalOrderId: paypalOrderId,
      //   verifiedOrder: verifiedOrder,
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'PayPal approval verified. Ready to place quote order.',
          ),
        ),
      );
    } catch (error, stackTrace) {
      log(
        'PayPal checkout failed',
        error: error,
        stackTrace: stackTrace,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PayPal checkout failed: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayPal Payment Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: _loading ? null : _startPaypalCheckout,
          child: _loading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : const Text('Pay with PayPal'),
        ),
      ),
    );
  }
}

/// Backend response after creating the PayPal order.
class PaypalCheckout {
  final String orderId;
  final String approvalUrl;

  const PaypalCheckout({
    required this.orderId,
    required this.approvalUrl,
  });
}

/// Replace these methods with your actual backend API calls.
class PaypalFlowService {
  Future<PaypalCheckout> createPaypalOrder() async {
    // POST /api/v2/paypal/set-express-checkout/{hid}
    //
    // Your backend creates the PayPal order from the current quote.
    //
    // Parse the returned PayPal order ID and approval URL here.
    throw UnimplementedError(
      'Connect this method to your backend create-order API.',
    );
  }

  Future<Map<String, dynamic>> verifyPaypalOrder(
      String paypalOrderId,
      ) async {
    // GET /api/v2/paypal/checkout/{paypalOrderId}
    //
    // Your backend verifies the PayPal order and returns its details.
    throw UnimplementedError(
      'Connect this method to your backend verification API.',
    );
  }
}

/// Displays the PayPal approval page and returns the PayPal Order ID.
///
/// This page does not capture payments.
class PaypalApprovalPage extends StatefulWidget {
  final String approvalUrl;

  const PaypalApprovalPage({
    super.key,
    required this.approvalUrl,
  });

  @override
  State<PaypalApprovalPage> createState() => _PaypalApprovalPageState();
}

class _PaypalApprovalPageState extends State<PaypalApprovalPage> {
  bool _completed = false;

  void _handleNavigation(Uri? uri) {
    if (uri == null || _completed) return;

    final token = uri.queryParameters['token'];

    // PayPal approval return normally contains the PayPal Order ID
    // in the "token" query parameter.
    if (token != null && token.isNotEmpty) {
      _completed = true;
      Navigator.of(context).pop(token);
      return;
    }

    // Handle cancellation. Adapt this to your backend's configured
    // PayPal cancel URL if your return URL differs.
    final status = uri.queryParameters['cancel'];

    if (status != null) {
      _completed = true;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Approval'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(widget.approvalUrl),
        ),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          useShouldOverrideUrlLoading: true,
        ),
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          _handleNavigation(navigationAction.request.url?.data?.uri);
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) {
          _handleNavigation(url?.data?.uri);
        },
        onReceivedError: (controller, request, error) {
          log('PayPal WebView error: ${error.description}');
        },
      ),
    );
  }
}