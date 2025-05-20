part of 'transaction_option.dart';

/// Represents a breakdown of the payment details.
///
/// The total amount in [PayPalAmount.total] must equal:
/// `subtotal + shipping - shippingDiscount`
///
/// This ensures consistency between the transaction amount and
/// the actual cost of the listed items and shipping terms.
/// 📌 Important: Make sure the total amount accurately reflects all costs.
/// PayPal will validate that the sum matches exactly before approving the transaction.
class PaymentDetails extends Equatable {
  /// - [subtotal]: The combined price of all items in the cart.
  ///   It must equal the sum of (price * quantity) of each item in [ItemList.items].
  final String subtotal;

  /// - [shipping]: The cost charged for delivering the goods to the buyer.
  ///   Set to `"0"` if shipping is free or not applicable (e.g., for digital goods).
  final String shipping;

  /// - [shippingDiscount]: Any discount applied to the shipping fee.
  ///   If no discount, set to `0`.
  final int shippingDiscount;

  const PaymentDetails({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'shipping': shipping,
    'shipping_discount': shippingDiscount,
  };

  @override
  List<Object?> get props => [subtotal, shipping, shippingDiscount];
}
