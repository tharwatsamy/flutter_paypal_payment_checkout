import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final String? recipientName;
  final String? line1;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? countryCode;

  const ShippingAddress({
    this.recipientName,
    this.line1,
    this.city,
    this.state,
    this.postalCode,
    this.countryCode,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      recipientName: json['recipient_name'] as String?,
      line1: json['line1'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postal_code'] as String?,
      countryCode: json['country_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'recipient_name': recipientName,
    'line1': line1,
    'city': city,
    'state': state,
    'postal_code': postalCode,
    'country_code': countryCode,
  };

  @override
  List<Object?> get props {
    return [recipientName, line1, city, state, postalCode, countryCode];
  }
}
