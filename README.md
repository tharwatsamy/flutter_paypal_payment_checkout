
# Flutter PayPal Payment Package

The Flutter PayPal Payment Package is a convenient solution that enables seamless integration of PayPal payments into your mobile application. This README provides an overview of the package and guides you on how to use it effectively.

## Installation

To install the Flutter PayPal Payment Package, follow these steps

1. Add the package to your project's dependencies in the `pubspec.yaml` file:
   ```yaml
   dependencies:
     flutter_paypal_payment: ^1.0.0
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
    ],
    onSuccess: (Map params) async {
        // Handle successful payment
 },
    onError: (error) {
        // Handle payment error
    },
    onCancel: () {
        // Handle payment cancellationImplement the onSuccess, onError, and onCancel callbacks to handle the respective payment outcomes.
    },
    );
    ```

## ⚡ Donate 

If you would like to support me, please consider making a donation through one of the following links:

* [PayPal](https://paypal.me/itharwat)

Thank you for your support!
