class ModelClass {
  Header? header;
  Esearchresult? esearchresult;

  ModelClass({this.header, this.esearchresult});

  ModelClass.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    esearchresult = json['esearchresult'] != null
        ? new Esearchresult.fromJson(json['esearchresult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.esearchresult != null) {
      data['esearchresult'] = this.esearchresult!.toJson();
    }
    return data;
  }
}

class Header {
  String? type;
  String? version;

  Header({this.type, this.version});

  Header.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['version'] = this.version;
    return data;
  }
}

class Esearchresult {
  String? count;
  String? retmax;
  String? retstart;
  List<String>? idlist;
  List<Translationset>? translationset;
  String? querytranslation;

  Esearchresult(
      {this.count,
      this.retmax,
      this.retstart,
      this.idlist,
      this.translationset,
      this.querytranslation});

  Esearchresult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    retmax = json['retmax'];
    retstart = json['retstart'];
    idlist = json['idlist'].cast<String>();
    if (json['translationset'] != null) {
      translationset = <Translationset>[];
      json['translationset'].forEach((v) {
        translationset!.add(new Translationset.fromJson(v));
      });
    }
    querytranslation = json['querytranslation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['retmax'] = this.retmax;
    data['retstart'] = this.retstart;
    data['idlist'] = this.idlist;
    if (this.translationset != null) {
      data['translationset'] =
          this.translationset!.map((v) => v.toJson()).toList();
    }
    data['querytranslation'] = this.querytranslation;
    return data;
  }
}

class Translationset {
  String? from;
  String? to;

  Translationset({this.from, this.to});

  Translationset.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
