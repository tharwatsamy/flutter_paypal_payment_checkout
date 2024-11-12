
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
PaypalCheckoutView(
  sandboxMode: true,
  clientId: "YOUR_CLIENT_ID",
  secretKey: "YOUR_SECRET_KEY",
  transactions: const [
    // Define your transaction details here
    {
      "amount": {"total": "10.00", "currency": "USD"},
      "description": "Payment for services rendered",
    },
  ],
  onSuccess: (Map params) async {
    // Handle successful payment
  },
  onError: (error) {
    // Handle payment error
  },
  onCancel: () {
    // Handle payment cancellation
    // Implement the onSuccess, onError, and onCancel callbacks to handle the respective payment outcomes.
  },
);
``` 
## ⚡ Donate 

If you would like to support me, please consider making a donation through one of the following links:

* [PayPal](https://paypal.me/itharwat)

Thank you for your support!