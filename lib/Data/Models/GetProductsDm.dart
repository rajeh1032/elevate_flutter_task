import 'package:movies/Domain/entitys/get_products_entity.dart';

class GetProductsDm extends GetProductsEntity {
  GetProductsDm({
    super.id,
    super.title,
    super.price,
    super.description,
    super.category,
    super.image,
    super.rating,
  });

  GetProductsDm.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? RatingDm.fromJson(json['rating']) : null;
  }

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

class RatingDm extends RatingEntity {
  RatingDm({
    super.rate,
    super.count,
  });

  RatingDm.fromJson(dynamic json) {
    rate = json['rate'] != null ? (json['rate'] as num).toDouble() : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    map['count'] = count;
    return map;
  }
}
