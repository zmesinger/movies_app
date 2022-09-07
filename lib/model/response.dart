import 'package:json_annotation/json_annotation.dart';

import 'search.dart';
@JsonSerializable(fieldRename: FieldRename.snake)

class Response {
  Response({
      this.search,
      this.totalResults,
      this.response,});

  Response.fromJson(dynamic json) {
    if (json['Search'] != null) {
      search = [];
      json['Search'].forEach((v) {
        search?.add(Search.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    response = json['Response'];
  }
  List<Search>? search;
  String? totalResults;
  String? response;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (search != null) {
      map['Search'] = search?.map((v) => v.toJson()).toList();
    }
    map['totalResults'] = totalResults;
    map['Response'] = response;
    return map;
  }



}