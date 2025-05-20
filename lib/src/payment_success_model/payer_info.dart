import 'package:equatable/equatable.dart';

import 'shipping_address.dart';

class PayerInfo extends Equatable {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? payerId;
  final ShippingAddress? shippingAddress;
  final String? countryCode;

  const PayerInfo({
    this.email,
    this.firstName,
    this.lastName,
    this.payerId,
    this.shippingAddress,
    this.countryCode,
  });

  factory PayerInfo.fromJson(Map<String, dynamic> json) => PayerInfo(
    email: json['email'] as String?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    payerId: json['payer_id'] as String?,
    shippingAddress:
        json['shipping_address'] == null
            ? null
            : ShippingAddress.fromJson(
              json['shipping_address'] as Map<String, dynamic>,
            ),
    countryCode: json['country_code'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'payer_id': payerId,
    'shipping_address': shippingAddress?.toJson(),
    'country_code': countryCode,
  };

  @override
  List<Object?> get props {
    return [email, firstName, lastName, payerId, shippingAddress, countryCode];
  }
}
