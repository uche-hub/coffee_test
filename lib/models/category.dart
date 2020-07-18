import './coffee.dart';

class Category {
    Category({
        this.name,
        this.coffeeList,
    });

    String name;
    List<Coffee> coffeeList;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        coffeeList: List<Coffee>.from(json["contents"].map((x) => Coffee.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "contents": List<dynamic>.from(coffeeList.map((x) => x.toJson())),
    };
}
