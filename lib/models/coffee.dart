
class Coffee {
    Coffee({
        this.category,
        this.title,
        this.price,
        this.url,
    });

    String category;
    String title;
    int price;
    String url;

    factory Coffee.fromJson(Map<String, dynamic> json) => Coffee(
        category: json["category"],
        title: json["title"],
        price: json["price"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "title": title,
        "price": price,
        "url": url,
    };
}