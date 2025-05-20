import 'package:equatable/equatable.dart';

import 'payer_info.dart';

class Payer extends Equatable {
  final String? paymentMethod;
  final String? status;
  final PayerInfo? payerInfo;

  const Payer({this.paymentMethod, this.status, this.payerInfo});

  factory Payer.fromJson(Map<String, dynamic> json) => Payer(
    paymentMethod: json['payment_method'] as String?,
    status: json['status'] as String?,
    payerInfo:
        json['payer_info'] == null
            ? null
            : PayerInfo.fromJson(json['payer_info'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'payment_method': paymentMethod,
    'status': status,
    'payer_info': payerInfo?.toJson(),
  };

  @override
  List<Object?> get props => [paymentMethod, status, payerInfo];
}
