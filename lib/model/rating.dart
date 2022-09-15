class Rating {
  Rating({
    this.source,
    this.value,
  });

  String? source;
  String? value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    source: json["Source"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Source": source,
    "Value": value,
  };
}
