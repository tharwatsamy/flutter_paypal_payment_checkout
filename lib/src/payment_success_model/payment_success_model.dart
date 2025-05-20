import 'package:equatable/equatable.dart';

import 'data.dart';

class PaymentSuccessModel extends Equatable {
  final bool? error;
  final String? message;
  final Data? data;

  const PaymentSuccessModel({this.error, this.message, this.data});

  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) {
    return PaymentSuccessModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'data': data?.toJson(),
  };

  @override
  List<Object?> get props => [error, message, data];
}
