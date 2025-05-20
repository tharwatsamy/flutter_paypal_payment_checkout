import 'package:equatable/equatable.dart';

import 'details.dart';

class Amount extends Equatable {
  final String? total;
  final String? currency;
  final Details? details;

  const Amount({this.total, this.currency, this.details});

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    total: json['total'] as String?,
    currency: json['currency'] as String?,
    details:
        json['details'] == null
            ? null
            : Details.fromJson(json['details'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'currency': currency,
    'details': details?.toJson(),
  };

  @override
  List<Object?> get props => [total, currency, details];
}
