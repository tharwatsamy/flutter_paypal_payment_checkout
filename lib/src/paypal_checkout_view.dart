library;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_paypal_payment/src/payment_success_model/payment_success_model.dart';
import 'package:flutter_paypal_payment/src/paypal_service.dart';
import 'package:flutter_paypal_payment/src/transaction_option/transaction_option.dart';

/// This class represents a PayPal checkout screen as a stateful widget.
/// It's stateful because it may undergo changes (like loading, error, or success) during the payment process.
class PaypalCheckoutView extends StatefulWidget {
  /// Callback function triggered when the payment is successful.
  /// It receives a [PaymentSuccessModel] containing details of the transaction.
  final Function(PaymentSuccessModel model) onSuccess;

  /// Callback function triggered when the payment process is canceled by the user.
  final Function onCancel;

  /// Callback function triggered when an error occurs during the payment process.
  final Function onError;

  /// Optional note or description associated with the payment.
  final String? note;

  /// Your PayPal client ID, required to authenticate API requests.
  final String? clientId;

  /// Your PayPal secret key, used along with the client ID for authorization.
  final String? secretKey;

  /// Optional custom [AppBar] to be shown on the checkout screen.
  final AppBar? appBar;

  /// Optional widget to show while the payment is loading or processing.
  final Widget? loadingIndicator;

  /// Transaction details such as amount, currency, item list, etc.
  final TransactionOption transactions;

  /// Whether to use the PayPal sandbox environment (for testing).
  /// Defaults to `false` for production/live mode.
  final bool? sandboxMode;

  /// Constructor for [PaypalCheckoutView], initializing required and optional fields.
  const PaypalCheckoutView({
    super.key,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    required this.transactions,
    required this.clientId,
    required this.secretKey,
    this.sandboxMode = false,
    this.note = '',
    this.loadingIndicator,
    this.appBar,
  });

  /// Creates the mutable state for this widget.
  @override
  State<StatefulWidget> createState() {
    return PaypalCheckoutViewState();
  }
}

class PaypalCheckoutViewState extends State<PaypalCheckoutView> {
  String? _checkoutUrl;
  String navUrl = '';
  String _executeUrl = '';
  String _accessToken = '';
  bool loading = true;
  bool pageLoading = true;
  bool loadingError = false;
  late PaypalServices _services;
  int pressed = 0;
  double progress = 0;
  final String returnURL =
      'https://www.youtube.com/channel/UC9a1yj1xV2zeyiFPZ1gGYGw';
  final String cancelURL = 'https://www.facebook.com/tharwat.samy.9';

  late InAppWebViewController webView;

  Map<String, dynamic> getOrderParams() {
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [widget.transactions.toJson()],
      "note_to_payer": widget.note,
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL},
    };
    return temp;
  }

  @override
  void initState() {
    _services = PaypalServices(
      sandboxMode: widget.sandboxMode!,
      clientId: widget.clientId!,
      secretKey: widget.secretKey!,
    );

    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        Map getToken = await _services.getAccessToken();

        if (getToken['token'] != null) {
          _accessToken = getToken['token'];
          final body = getOrderParams();
          final res = await _services.createPaypalPayment(body, _accessToken);

          if (res["approvalUrl"] != null) {
            setState(() {
              _checkoutUrl = res["approvalUrl"];
              _executeUrl = res["executeUrl"];
            });
          } else {
            widget.onError(res);
          }
        } else {
          widget.onError("${getToken['message']}");
        }
      } catch (e) {
        widget.onError(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkoutUrl != null) {
      return Scaffold(
        appBar:
            widget.appBar ??
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text("Paypal Payment"),
            ),
        body: Stack(
          children: <Widget>[
            InAppWebView(
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final url = navigationAction.request.url;

                if (url.toString().contains(returnURL)) {
                  _executePayment(url, context);
                  return NavigationActionPolicy.CANCEL;
                }
                if (url.toString().contains(cancelURL)) {
                  return NavigationActionPolicy.CANCEL;
                } else {
                  return NavigationActionPolicy.ALLOW;
                }
              },
              initialUrlRequest: URLRequest(url: WebUri(_checkoutUrl!)),
              // initialOptions: InAppWebViewGroupOptions(
              //   crossPlatform: InAppWebViewOptions(
              //     useShouldOverrideUrlLoading: true,
              //   ),
              // ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onCloseWindow: (InAppWebViewController controller) {
                widget.onCancel();
              },
              onProgressChanged: (
                InAppWebViewController controller,
                int progress,
              ) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            progress < 1
                ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(value: progress),
                )
                : const SizedBox(),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar:
            widget.appBar ??
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text("Paypal Payment"),
            ),
        body: Center(
          child: widget.loadingIndicator ?? const CircularProgressIndicator(),
        ),
      );
    }
  }

  void _executePayment(Uri? url, BuildContext context) {
    final payerID = url!.queryParameters['PayerID'];
    if (payerID != null) {
      _services.executePayment(_executeUrl, payerID, _accessToken).then((id) {
        if (id['error'] == false) {
          PaymentSuccessModel model = PaymentSuccessModel.fromJson(id);
          widget.onSuccess(model);
        } else {
          widget.onError(id);
        }
      });
    } else {
      widget.onError('Something went wront PayerID == null');
    }
  }
}
