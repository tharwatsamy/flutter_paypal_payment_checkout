import 'package:equatable/equatable.dart';

import 'link.dart';
import 'payer.dart';
import 'transaction.dart';

class Data extends Equatable {
  final String? id;
  final String? intent;
  final String? state;
  final String? cart;
  final Payer? payer;
  final List<Transaction>? transactions;
  final List<dynamic>? failedTransactions;
  final String? createTime;
  final String? updateTime;
  final List<Link>? links;

  const Data({
    this.id,
    this.intent,
    this.state,
    this.cart,
    this.payer,
    this.transactions,
    this.failedTransactions,
    this.createTime,
    this.updateTime,
    this.links,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as String?,
    intent: json['intent'] as String?,
    state: json['state'] as String?,
    cart: json['cart'] as String?,
    payer:
        json['payer'] == null
            ? null
            : Payer.fromJson(json['payer'] as Map<String, dynamic>),
    transactions:
        (json['transactions'] as List<dynamic>?)
            ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList(),
    failedTransactions: json['failed_transactions'] as List<dynamic>?,
    createTime: json['create_time'] as String?,
    updateTime: json['update_time'] as String?,
    links:
        (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'intent': intent,
    'state': state,
    'cart': cart,
    'payer': payer?.toJson(),
    'transactions': transactions?.map((e) => e.toJson()).toList(),
    'failed_transactions': failedTransactions,
    'create_time': createTime,
    'update_time': updateTime,
    'links': links?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props {
    return [
      id,
      intent,
      state,
      cart,
      payer,
      transactions,
      failedTransactions,
      createTime,
      updateTime,
      links,
    ];
  }
}
