// To parse this JSON data, do
//
//     final cafe = cafeFromJson(jsonString);

import './category.dart';

class Cafe {
    Cafe({
        this.categories,
    });

    List<Category> categories;

    factory Cafe.fromJson(Map<String, dynamic> json) => Cafe(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

