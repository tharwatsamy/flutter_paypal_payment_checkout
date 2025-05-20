import 'package:equatable/equatable.dart';

class Details extends Equatable {
  final String? subtotal;
  final String? shipping;
  final String? insurance;
  final String? handlingFee;
  final String? shippingDiscount;
  final String? discount;

  const Details({
    this.subtotal,
    this.shipping,
    this.insurance,
    this.handlingFee,
    this.shippingDiscount,
    this.discount,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    subtotal: json['subtotal'] as String?,
    shipping: json['shipping'] as String?,
    insurance: json['insurance'] as String?,
    handlingFee: json['handling_fee'] as String?,
    shippingDiscount: json['shipping_discount'] as String?,
    discount: json['discount'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'shipping': shipping,
    'insurance': insurance,
    'handling_fee': handlingFee,
    'shipping_discount': shippingDiscount,
    'discount': discount,
  };

  @override
  List<Object?> get props {
    return [
      subtotal,
      shipping,
      insurance,
      handlingFee,
      shippingDiscount,
      discount,
    ];
  }
}
