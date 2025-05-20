import 'package:equatable/equatable.dart';

import 'sale.dart';

class RelatedResource extends Equatable {
  final Sale? sale;

  const RelatedResource({this.sale});

  factory RelatedResource.fromJson(Map<String, dynamic> json) {
    return RelatedResource(
      sale:
          json['sale'] == null
              ? null
              : Sale.fromJson(json['sale'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {'sale': sale?.toJson()};

  @override
  List<Object?> get props => [sale];
}
