library;

import 'package:equatable/equatable.dart';

part 'paypal_amount.dart';
part 'payment_options.dart';
part 'item_list.dart';
part 'item.dart';
part 'payment_details.dart';
part 'shipping_address.dart';

/// Represents a single payment transaction option in the PayPal payment process.
///
/// This class bundles together the total payment amount,
/// a descriptive text about the transaction, optional payment options,
/// and the list of items involved in the transaction.
class TransactionOption extends Equatable {
  /// - [amount]: The total amount of the transaction including currency and payment breakdown.
  ///   The `total` in [amount] must exactly match the sum of prices in [itemList].
  /// 📌 Make sure that the total amount in [amount] aligns with the sum of item prices in [itemList]
  /// to avoid discrepancies during payment processing.
  final PayPalAmount amount;

  /// - [description]: A brief description of the transaction, shown to the payer.
  final String description;

  /// - [paymentOptions]: Optional settings specifying allowed payment methods for this transaction.
  final PaymentOptions? paymentOptions;

  /// - [itemList]: Contains the list of items included in the transaction along with an optional shipping address.
  final ItemList itemList;

  const TransactionOption({
    required this.amount,
    required this.description,
    this.paymentOptions,
    required this.itemList,
  });

  /// Checks if the total amount matches the sum of all items in the itemList.
  /// Returns true if they match, otherwise false.
  bool _isAmountConsistent() {
    // Calculate the total price of all items (price * quantity)
    double totalItemsPrice = itemList.items.fold(0.0, (sum, item) {
      final price = double.tryParse(item.price) ?? 0.0;
      return sum + (price * item.quantity);
    });

    // Parse subtotal, shipping, and shippingDiscount values to double
    final subtotalValue = double.tryParse(amount.details.subtotal) ?? 0.0;
    final shippingValue = double.tryParse(amount.details.shipping) ?? 0.0;
    final shippingDiscountValue = amount.details.shippingDiscount.toDouble();

    // Calculate the expected total based on payment details
    final expectedTotal = subtotalValue + shippingValue - shippingDiscountValue;

    // Parse the total amount to double
    final totalAmount = double.tryParse(amount.total) ?? 0.0;

    // Define a small epsilon to allow for floating-point precision errors
    const epsilon = 0.0001;

    // Verify if subtotal matches the sum of item prices
    bool isSubtotalMatching = (subtotalValue - totalItemsPrice).abs() < epsilon;
    if (!isSubtotalMatching) {
      throw Exception(
        'Total amount does not match sum of payment details\'s subtotal please check all failed',
      );
    }
    // Verify if total matches the calculated expected total (subtotal + shipping - discount)
    bool isTotalMatching = (totalAmount - expectedTotal).abs() < epsilon;
    if (!isTotalMatching) {
      throw Exception('Total amount does not match sum of prices of Items');
    }
    // Return true only if both subtotal and total amounts are consistent
    return isSubtotalMatching && isTotalMatching;
  }

  Map<String, dynamic> toJson() {
    if (!_isAmountConsistent()) {
      throw Exception(
        'Total amount does not match sum of item prices Or payment details check failed',
      );
    }

    return {
      'amount': amount.toJson(),
      'description': description,
      if (paymentOptions != null) 'payment_options': paymentOptions?.toJson(),
      'item_list': itemList.toJson(),
    };
  }

  @override
  List<Object?> get props {
    return [amount, description, paymentOptions, itemList];
  }
}
