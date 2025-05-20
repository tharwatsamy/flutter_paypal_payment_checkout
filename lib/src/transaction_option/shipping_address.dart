part of 'transaction_option.dart';

/// Represents the shipping address details for the transaction.
///
/// This information is optional and used to specify
/// the destination where the purchased items will be delivered.
/// 📌 Note:
/// Including a valid shipping address ensures proper delivery and
/// may be required depending on the payment and shipping methods used.
class ShippingAddress extends Equatable {
  /// - [recipientName]: The full name of the person receiving the shipment.
  final String? recipientName;

  /// - [line1]: The primary street address (e.g., building number and street).
  final String? line1;

  /// - [line2]: Additional address information (e.g., apartment, suite, unit).
  final String? line2;

  /// - [city]: The city of the shipping address.
  final String? city;

  /// - [countryCode]: The two-letter ISO country code (e.g., "US", "GB").
  final String? countryCode;

  /// - [postalCode]: The postal or ZIP code for the address.
  final String? postalCode;

  /// - [phone]: Contact phone number for the recipient (optional).
  final String? phone;

  /// - [state]: State, province, or region.
  final String? state;

  const ShippingAddress({
    this.recipientName,
    this.line1,
    this.line2,
    this.city,
    this.countryCode,
    this.postalCode,
    this.phone,
    this.state,
  });

  Map<String, dynamic> toJson() => {
    if (recipientName != null) 'recipient_name': recipientName,
    if (line1 != null) 'line1': line1,
    if (line2 != null) 'line2': line2,
    if (city != null) 'city': city,
    if (countryCode != null) 'country_code': countryCode,
    if (postalCode != null) 'postal_code': postalCode,
    if (phone != null) 'phone': phone,
    if (state != null) 'state': state,
  };

  @override
  List<Object?> get props {
    return [
      recipientName,
      line1,
      line2,
      city,
      countryCode,
      postalCode,
      phone,
      state,
    ];
  }
}
