import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String? name;
  final String? price;
  final String? currency;
  final String? tax;
  final int? quantity;

  const Item({this.name, this.price, this.currency, this.tax, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json['name'] as String?,
    price: json['price'] as String?,
    currency: json['currency'] as String?,
    tax: json['tax'] as String?,
    quantity: json['quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'currency': currency,
    'tax': tax,
    'quantity': quantity,
  };

  @override
  List<Object?> get props => [name, price, currency, tax, quantity];
}
