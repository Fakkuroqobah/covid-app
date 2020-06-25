import 'dart:convert';

AboutModel aboutModelFromJson(String str) => AboutModel.fromJson(json.decode(str));

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  AboutModel({
    this.login,
    this.avatarUrl,
    this.htmlUrl,
    this.name,
  });

  String login;
  String avatarUrl;
  String htmlUrl;
  String name;
  String error;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    login: json["login"],
    avatarUrl: json["avatar_url"],
    htmlUrl: json["html_url"],
    name: json["name"],
  );

  AboutModel.withError(this.error);

  Map<String, dynamic> toJson() => {
    "login": login,
    "avatar_url": avatarUrl,
    "html_url": htmlUrl,
    "name": name,
  };
}