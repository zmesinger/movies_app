import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';


class Response {
  List<Movie>? movies;
  String? totalResults;
  String? response;

  Response({
      this.movies,
      this.totalResults,
      this.response,});

  Response.fromJson(dynamic json) {
    if (json['Search'] != null) {
      movies = [];
      json['Search'].forEach((v) {
        movies?.add(Movie.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    response = json['Response'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movies != null) {
      map['Search'] = movies?.map((v) => v.toJson()).toList();
    }
    map['totalResults'] = totalResults;
    map['Response'] = response;
    return map;
  }



}