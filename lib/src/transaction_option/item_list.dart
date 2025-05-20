part of 'transaction_option.dart';

/// Represents the list of items included in a payment transaction.
/// This class holds the collection of purchased items along with an optional

class ItemList extends Equatable {
  /// - [items]: A list of [Item] objects representing each product or service in the transaction.
  ///   The total sum of all items' prices * quantities should exactly match the `total`
  ///   field in the associated [PayPalAmount] to ensure consistency and prevent payment errors.
  /// 📌 Important:
  /// Always verify that the aggregated total of `items` aligns with the `PayPalAmount.total`.
  /// Discrepancies may lead to transaction rejection or payment processing errors.
  final List<Item> items;

  /// shipping address associated with the transaction.
  /// - [shippingAddress]: Optional shipping address for the transaction.
  ///   If omitted, PayPal will use the payer's default shipping address.
  final ShippingAddress? shippingAddress;

  const ItemList({required this.items, this.shippingAddress});

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
    if (shippingAddress != null) 'shipping_address': shippingAddress?.toJson(),
  };

  @override
  List<Object?> get props => [items, shippingAddress];
}
