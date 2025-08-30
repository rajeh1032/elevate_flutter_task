class GetProductsEntity {
  GetProductsEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  GetProductsEntity.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? RatingEntity.fromJson(json['rating']) : null;
  }

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  RatingEntity? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['category'] = category;
    map['image'] = image;
    if (rating != null) {
      map['rating'] = rating?.toJson();
    }
    return map;
  }
}

class RatingEntity {
  RatingEntity({
    this.rate,
    this.count,
  });

  RatingEntity.fromJson(dynamic json) {
    rate = json['rate'] != null ? (json['rate'] as num).toDouble() : null;
    count = json['count'];
  }

  double? rate;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    map['count'] = count;
    return map;
  }
}
