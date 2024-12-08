
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
 Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId: "",
                    secretKey: "",
                    transactions: const [
                      {
                        "amount": {
                          "total": '70',
                          "currency": "USD",
                          "details": {
                            "subtotal": '70',
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },
                        "item_list": {
                          "items": [
                            {
                              "name": "Apple",
                              "quantity": 4,
                              "price": '5',
                              "currency": "USD"
                            },
                            {
                              "name": "Pineapple",
                              "quantity": 5,
                              "price": '10',
                              "currency": "USD"
                            }
                          ],

                          // shipping address is not required though
                          //   "shipping_address": {
                          //     "recipient_name": "tharwat",
                          //     "line1": "Alexandria",
                          //     "line2": "",
                          //     "city": "Alexandria",
                          //     "country_code": "EG",
                          //     "postal_code": "21505",
                          //     "phone": "+00000000",
                          //     "state": "Alexandria"
                          //  },
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                    },
                    onError: (error) {
                      print("onError: $error");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      print('cancelled:');
                    },
                  ),
                ));
``` 
## ⚡ Donate 

If you would like to support me, please consider making a donation through one of the following links:

* [PayPal](https://paypal.me/itharwat)

Thank you for your support!
