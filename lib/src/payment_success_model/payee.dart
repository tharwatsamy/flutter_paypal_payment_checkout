import 'package:equatable/equatable.dart';

class Payee extends Equatable {
  final String? merchantId;
  final String? email;

  const Payee({this.merchantId, this.email});

  factory Payee.fromJson(Map<String, dynamic> json) => Payee(
    merchantId: json['merchant_id'] as String?,
    email: json['email'] as String?,
  );

  Map<String, dynamic> toJson() => {'merchant_id': merchantId, 'email': email};

  @override
  List<Object?> get props => [merchantId, email];
}
