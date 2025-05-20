import 'package:equatable/equatable.dart';

import 'amount.dart';
import 'item_list.dart';
import 'payee.dart';
import 'related_resource.dart';

class Transaction extends Equatable {
  final Amount? amount;
  final Payee? payee;
  final String? description;
  final String? softDescriptor;
  final ItemList? itemList;
  final List<RelatedResource>? relatedResources;

  const Transaction({
    this.amount,
    this.payee,
    this.description,
    this.softDescriptor,
    this.itemList,
    this.relatedResources,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    amount:
        json['amount'] == null
            ? null
            : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    payee:
        json['payee'] == null
            ? null
            : Payee.fromJson(json['payee'] as Map<String, dynamic>),
    description: json['description'] as String?,
    softDescriptor: json['soft_descriptor'] as String?,
    itemList:
        json['item_list'] == null
            ? null
            : ItemList.fromJson(json['item_list'] as Map<String, dynamic>),
    relatedResources:
        (json['related_resources'] as List<dynamic>?)
            ?.map((e) => RelatedResource.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'amount': amount?.toJson(),
    'payee': payee?.toJson(),
    'description': description,
    'soft_descriptor': softDescriptor,
    'item_list': itemList?.toJson(),
    'related_resources': relatedResources?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props {
    return [
      amount,
      payee,
      description,
      softDescriptor,
      itemList,
      relatedResources,
    ];
  }
}
