class ProductItemModel {
  List<Images>? images;

  ProductItemModel({this.images});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? url;
  String? largeUrl;
  int? sourceId;
  int? price=20;
  int quantity=0;

  Images({this.id, this.url, this.largeUrl, this.sourceId,this.price=20,this.quantity=0});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    largeUrl = json['large_url'];
    sourceId = json['source_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['large_url'] = this.largeUrl;
    data['source_id'] = this.sourceId;
    return data;
  }
}