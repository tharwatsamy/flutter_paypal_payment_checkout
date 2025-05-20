part of 'transaction_option.dart';

/// Represents the total payment amount to be charged via PayPal.
///
/// 🔐 **Validation Note:**
/// The [total] must equal the sum of the [PaymentDetails]:
/// `total = subtotal + shipping - shippingDiscount`
///
/// This ensures the integrity of the transaction and prevents mismatches
/// between what is declared and what PayPal expects.
/// If there's a mismatch, PayPal may reject the payment request.
class PayPalAmount extends Equatable {
  /// - [total]: The final amount to be charged from the buyer.
  ///   Must match the breakdown in [details].
  /// ✅ Tip: Always validate that the sum of item prices (in `ItemList`) equals `details.subtotal`,
  /// and that `total` matches the computed breakdown.
  final String total;

  /// - [currency]: The currency code (e.g., "USD", "EUR") used for this transaction.
  ///   It must match the currency used in each [Item].
  final String currency;

  /// - [details]: A breakdown of the payment including item subtotal,
  ///   shipping cost, and any applicable shipping discounts.
  final PaymentDetails details;

  const PayPalAmount({
    required this.total,
    required this.currency,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
    'total': total,
    'currency': currency,
    'details': details.toJson(),
  };

  @override
  List<Object?> get props => [total, currency, details];
}
