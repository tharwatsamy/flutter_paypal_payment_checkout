/// Entry point of the application.
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_paypal_payment/src/transaction_option/transaction_option.dart';

/// The main function is the starting point of the Flutter application.
void main() {
  runApp(const PaypalPaymentDemo());
}

/// A stateless widget that demonstrates PayPal payment integration.
class PaypalPaymentDemo extends StatelessWidget {
  const PaypalPaymentDemo({super.key});

  /// Builds the MaterialApp widget for the demo.
  ///
  /// Contains a button which navigates to the PayPal checkout view when pressed.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaypalPaymentDemo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: TextButton(
            /// When pressed, navigates to the PayPal checkout screen.
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    /// Whether to use PayPal's sandbox mode for testing.
                    sandboxMode: true,

                    /// Your PayPal REST API client ID.
                    clientId: "",

                    /// Your PayPal REST API secret key.
                    secretKey: "",

                    /// Transaction details including items and total amount.
                    transactions: const TransactionOption(
                      amount: PayPalAmount(
                        total: "100",
                        currency: "USD",
                        details: PaymentDetails(
                          subtotal: '100',
                          shipping: "0",
                          shippingDiscount: 0,
                        ),
                      ),
                      description: "The payment transaction description.",
                      itemList: ItemList(
                        items: [
                          Item(
                            name: "apple",
                            quantity: 1,
                            price: "50",
                            currency: "USD",
                          ),
                          Item(
                            name: "Pineapple",
                            quantity: 5,
                            price: "10",
                            currency: "USD",
                          ),
                        ],
                      ),
                    ),

                    /// Optional note shown to the user about the order.
                    note: "Contact us for any questions on your order.",

                    /// Callback triggered when the payment is successful.
                    /// Logs the result and returns to the previous screen.
                    onSuccess: (model) async {
                      log("onSuccess:${model.toJson()}");
                      Navigator.pop(context);
                    },

                    /// Callback triggered when an error occurs during payment.
                    onError: (error) {
                      log("onError: $error");
                      Navigator.pop(context);
                    },

                    /// Callback triggered when the user cancels the payment.
                    onCancel: () {
                      print('cancelled:');
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            child: const Text('Pay with paypal'),
          ),
        ),
      ),
    );
  }
}
