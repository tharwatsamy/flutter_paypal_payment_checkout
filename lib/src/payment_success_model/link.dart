import 'package:equatable/equatable.dart';

class Link extends Equatable {
  final String? href;
  final String? rel;
  final String? method;

  const Link({this.href, this.rel, this.method});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    href: json['href'] as String?,
    rel: json['rel'] as String?,
    method: json['method'] as String?,
  );

  Map<String, dynamic> toJson() => {'href': href, 'rel': rel, 'method': method};

  @override
  List<Object?> get props => [href, rel, method];
}
