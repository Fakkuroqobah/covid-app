import 'dart:convert';

IndonesiaModel indonesiaModelFromJson(String str) => IndonesiaModel.fromJson(json.decode(str));

String indonesiaModelToJson(IndonesiaModel data) => json.encode(data.toJson());

class IndonesiaModel {
  IndonesiaModel({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.lastUpdate,
  });

  Confirmed confirmed;
  Confirmed recovered;
  Confirmed deaths;
  DateTime lastUpdate;
  String error;

  factory IndonesiaModel.fromJson(Map<String, dynamic> json) => IndonesiaModel(
    confirmed: Confirmed.fromJson(json["confirmed"]),
    recovered: Confirmed.fromJson(json["recovered"]),
    deaths: Confirmed.fromJson(json["deaths"]),
    lastUpdate: DateTime.parse(json["lastUpdate"]),
  );

  IndonesiaModel.withError(this.error);

  Map<String, dynamic> toJson() => {
    "confirmed": confirmed.toJson(),
    "recovered": recovered.toJson(),
    "deaths": deaths.toJson(),
    "lastUpdate": lastUpdate.toIso8601String(),
  };
}

class Confirmed {
  Confirmed({
    this.value,
    this.detail,
  });

  int value;
  String detail;

  factory Confirmed.fromJson(Map<String, dynamic> json) => Confirmed(
    value: json["value"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "detail": detail,
  };
}