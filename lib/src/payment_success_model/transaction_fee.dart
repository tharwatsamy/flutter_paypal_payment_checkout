import 'package:equatable/equatable.dart';

class TransactionFee extends Equatable {
  final String? value;
  final String? currency;

  const TransactionFee({this.value, this.currency});

  factory TransactionFee.fromJson(Map<String, dynamic> json) {
    return TransactionFee(
      value: json['value'] as String?,
      currency: json['currency'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'value': value, 'currency': currency};

  @override
  List<Object?> get props => [value, currency];
}
