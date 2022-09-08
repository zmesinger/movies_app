import 'dart:convert';
import 'package:movies_app/model/search.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.search,
    this.totalResults,
    this.response,
  });

  List<Search> search;
  String? totalResults;
  String? response;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    search: List<Search>.from(json["Search"].map((x) => Search.fromJson(x))),
    totalResults: json["totalResults"],
    response: json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "Search": List<dynamic>.from(search.map((x) => x.toJson())),
    "totalResults": totalResults,
    "Response": response,
  };
}
