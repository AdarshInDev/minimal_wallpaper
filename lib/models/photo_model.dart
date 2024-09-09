class PhotoModel {
  String? url;
  String? photographer;
  SrcModel? src;

  PhotoModel({ this.url,  this.src, this.photographer});

  factory PhotoModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotoModel(
        url: parsedJson["url"],
        src: SrcModel.fromMap(
          parsedJson["src"],
        ),
        photographer: parsedJson["photographer"]);
  }
}

class SrcModel {
  String? portrait;
  String? large;
  String? landscape;
  String? medium;
  SrcModel({this.portrait, this.large, this.landscape, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
