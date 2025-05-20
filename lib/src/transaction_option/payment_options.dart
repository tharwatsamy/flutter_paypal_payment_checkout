part of 'transaction_option.dart';

/// Defines the payment options allowed for the transaction.
///
/// This class specifies which payment methods are permitted
/// during the checkout process.
class PaymentOptions extends Equatable {
  /// - [allowedPaymentMethod]:
  ///   A string indicating the allowed payment method,
  ///   e.g., `"INSTANT_FUNDING_SOURCE"` to allow instant funding options like credit card or PayPal balance.
  ///
  /// 📌 Note:
  /// Make sure the allowed payment method value complies with PayPal’s API specification
  /// to avoid payment failures or rejections.
  final PaymentMethodEnum allowedPaymentMethod;

  const PaymentOptions({required this.allowedPaymentMethod});

  Map<String, dynamic> toJson() => {
    'allowed_payment_method': getPaymentMethod(allowedPaymentMethod),
  };

  @override
  List<Object?> get props => [allowedPaymentMethod];
}

enum PaymentMethodEnum { INSTANT_FUNDING_SOURCE, CREDIT_CARD, PAYPAL }

String getPaymentMethod(PaymentMethodEnum paymentMethod) {
  switch (paymentMethod) {
    case PaymentMethodEnum.INSTANT_FUNDING_SOURCE:
      return "INSTANT_FUNDING_SOURCE";
    case PaymentMethodEnum.CREDIT_CARD:
      return "CREDIT_CARD";
    case PaymentMethodEnum.PAYPAL:
      return "PAYPAL";
  }
}
