import 'package:equatable/equatable.dart';

import 'item.dart';
import 'shipping_address.dart';

class ItemList extends Equatable {
  final List<Item>? items;
  final ShippingAddress? shippingAddress;

  const ItemList({this.items, this.shippingAddress});

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    items:
        (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
    shippingAddress:
        json['shipping_address'] == null
            ? null
            : ShippingAddress.fromJson(
              json['shipping_address'] as Map<String, dynamic>,
            ),
  );

  Map<String, dynamic> toJson() => {
    'items': items?.map((e) => e.toJson()).toList(),
    'shipping_address': shippingAddress?.toJson(),
  };

  @override
  List<Object?> get props => [items, shippingAddress];
}
