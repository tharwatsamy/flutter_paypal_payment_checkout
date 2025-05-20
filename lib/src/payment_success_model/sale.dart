import 'package:equatable/equatable.dart';

import 'amount.dart';
import 'link.dart';
import 'transaction_fee.dart';

class Sale extends Equatable {
  final String? id;
  final String? state;
  final Amount? amount;
  final String? paymentMode;
  final String? protectionEligibility;
  final String? protectionEligibilityType;
  final TransactionFee? transactionFee;
  final String? parentPayment;
  final String? createTime;
  final String? updateTime;
  final List<Link>? links;
  final String? softDescriptor;

  const Sale({
    this.id,
    this.state,
    this.amount,
    this.paymentMode,
    this.protectionEligibility,
    this.protectionEligibilityType,
    this.transactionFee,
    this.parentPayment,
    this.createTime,
    this.updateTime,
    this.links,
    this.softDescriptor,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    id: json['id'] as String?,
    state: json['state'] as String?,
    amount:
        json['amount'] == null
            ? null
            : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    paymentMode: json['payment_mode'] as String?,
    protectionEligibility: json['protection_eligibility'] as String?,
    protectionEligibilityType: json['protection_eligibility_type'] as String?,
    transactionFee:
        json['transaction_fee'] == null
            ? null
            : TransactionFee.fromJson(
              json['transaction_fee'] as Map<String, dynamic>,
            ),
    parentPayment: json['parent_payment'] as String?,
    createTime: json['create_time'] as String?,
    updateTime: json['update_time'] as String?,
    links:
        (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
    softDescriptor: json['soft_descriptor'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'state': state,
    'amount': amount?.toJson(),
    'payment_mode': paymentMode,
    'protection_eligibility': protectionEligibility,
    'protection_eligibility_type': protectionEligibilityType,
    'transaction_fee': transactionFee?.toJson(),
    'parent_payment': parentPayment,
    'create_time': createTime,
    'update_time': updateTime,
    'links': links?.map((e) => e.toJson()).toList(),
    'soft_descriptor': softDescriptor,
  };

  @override
  List<Object?> get props {
    return [
      id,
      state,
      amount,
      paymentMode,
      protectionEligibility,
      protectionEligibilityType,
      transactionFee,
      parentPayment,
      createTime,
      updateTime,
      links,
      softDescriptor,
    ];
  }
}
