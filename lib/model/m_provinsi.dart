import 'dart:convert';

List<ProvinsiModel> provinsiModelFromJson(String str) => List<ProvinsiModel>.from(json.decode(str).map((x) => ProvinsiModel.fromJson(x)));

String provinsiModelToJson(List<ProvinsiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvinsiModel {
  ProvinsiModel({
    this.fid,
    this.kodeProvi,
    this.provinsi,
    this.kasusPosi,
    this.kasusSemb,
    this.kasusMeni,
  });

  int fid;
  int kodeProvi;
  String provinsi;
  int kasusPosi;
  int kasusSemb;
  int kasusMeni;

  factory ProvinsiModel.fromJson(Map<String, dynamic> json) => ProvinsiModel(
    fid: json["fid"],
    kodeProvi: json["kodeProvi"],
    provinsi: json["provinsi"],
    kasusPosi: json["kasusPosi"],
    kasusSemb: json["kasusSemb"],
    kasusMeni: json["kasusMeni"],
  );

  Map<String, dynamic> toJson() => {
    "fid": fid,
    "kodeProvi": kodeProvi,
    "provinsi": provinsi,
    "kasusPosi": kasusPosi,
    "kasusSemb": kasusSemb,
    "kasusMeni": kasusMeni,
  };
}
