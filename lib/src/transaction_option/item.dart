part of 'transaction_option.dart';

class Item extends Equatable {
  /// - [name]: The name or title of the item.
  final String name;

  /// - [quantity]: The quantity of this item being purchased. Must be a positive integer.
  final int quantity;

  /// - [price]: The price per unit of the item, represented as a string.
  ///   This should be a numeric value formatted as a decimal string (e.g., "15.99").
  /// 📌 Important:
  /// - The total price for this item is `price * quantity`.
  /// - Ensure consistency of currency across all items and the overall transaction.
  /// - The sum of all item totals should match the subtotal in [PaymentDetails].
  final String price;

  /// - [currency]: The currency code (e.g., "USD", "EUR") used for this item's price.
  ///   This should match the currency used throughout the transaction.
  final String currency;
  const Item({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'price': price,
    'currency': currency,
  };

  @override
  List<Object?> get props => [name, quantity, price, currency];
}
