import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Search {
  Search({
      this.title, 
      this.year, 
      this.imdbID,
      this.type, 
      this.poster,});

  Search.fromJson(dynamic json) {
    title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
  }
  String? title;
  String? year;
  String? imdbID;
  String? type;
  String? poster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = title;
    map['Year'] = year;
    map['imdbID'] = imdbID;
    map['Type'] = type;
    map['Poster'] = poster;
    return map;
  }

}