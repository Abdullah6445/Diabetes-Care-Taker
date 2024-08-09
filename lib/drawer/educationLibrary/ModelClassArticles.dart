// To parse this JSON data, do
//
//     final diabetesModelClass = diabetesModelClassFromJson(jsonString);

import 'dart:convert';

DiabetesModelClass diabetesModelClassFromJson(String str) =>
    DiabetesModelClass.fromJson(json.decode(str));

String diabetesModelClassToJson(DiabetesModelClass data) =>
    json.encode(data.toJson());

class DiabetesModelClass {
  Header header;
  Esearchresult esearchresult;

  DiabetesModelClass({
    required this.header,
    required this.esearchresult,
  });

  factory DiabetesModelClass.fromJson(Map<String, dynamic> json) =>
      DiabetesModelClass(
        header: Header.fromJson(json["header"]),
        esearchresult: Esearchresult.fromJson(json["esearchresult"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "esearchresult": esearchresult.toJson(),
      };
}

class Esearchresult {
  String count;
  String retmax;
  String retstart;
  List<String> idlist;
  List<Translationset> translationset;
  String querytranslation;

  Esearchresult({
    required this.count,
    required this.retmax,
    required this.retstart,
    required this.idlist,
    required this.translationset,
    required this.querytranslation,
  });

  factory Esearchresult.fromJson(Map<String, dynamic> json) => Esearchresult(
        count: json["count"],
        retmax: json["retmax"],
        retstart: json["retstart"],
        idlist: List<String>.from(json["idlist"].map((x) => x)),
        translationset: List<Translationset>.from(
            json["translationset"].map((x) => Translationset.fromJson(x))),
        querytranslation: json["querytranslation"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "retmax": retmax,
        "retstart": retstart,
        "idlist": List<dynamic>.from(idlist.map((x) => x)),
        "translationset":
            List<dynamic>.from(translationset.map((x) => x.toJson())),
        "querytranslation": querytranslation,
      };
}

class Translationset {
  String from;
  String to;

  Translationset({
    required this.from,
    required this.to,
  });

  factory Translationset.fromJson(Map<String, dynamic> json) => Translationset(
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

class Header {
  String type;
  String version;

  Header({
    required this.type,
    required this.version,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        type: json["type"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "version": version,
      };
}
