
# Flutter PayPal Payment Package

The **Flutter PayPal Payment Package** provides an easy-to-integrate solution for enabling PayPal payments in your Flutter mobile application. This package allows for a seamless checkout experience with both sandbox and production environments.

## Features

- **Seamless PayPal Integration**: Easily integrate PayPal payments into your Flutter app.
- **Sandbox Mode Support**: Test payments in a safe sandbox environment before going live.
- **Customizable Transactions**: Define custom transaction details for each payment.
- **Payment Outcome Callbacks**: Handle success, error, and cancellation events for payments.

## Installation

To install the Flutter PayPal Payment Package, follow these steps

1. Add the package to your project's dependencies in the `pubspec.yaml` file:
   ```yaml
   dependencies:
     flutter_paypal_payment: ^1.0.7
    ``` 
2. Run the following command to fetch the package:

    ``` 
    flutter pub get
    ``` 

## Usage
1. Import the package into your Dart file:

    ``` 
    import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
    ```
2. Navigate to the PayPal checkout view with the desired configuration:
```dart
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
``` 
## ⚡ Donate 

If you would like to support me, please consider making a donation through one of the following links:

* [PayPal](https://paypal.me/itharwat)

Thank you for your support!
