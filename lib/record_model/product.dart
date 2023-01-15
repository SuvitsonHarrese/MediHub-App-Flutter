// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        required this.averageStar,
        required this.discount,
        required this.mrp,
        required this.price,
        required this.productName,
        required this.productLink,
        required this.quantity,
        required this.rating,
    });

    String averageStar;
    String discount;
    String mrp;
    String price;
    String productName;
    String productLink;
    String quantity;
    String rating;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        averageStar: json["Average star"],
        discount: json["Discount"],
        mrp: json["MRP"],
        price: json["Price"],
        productName: json["Product Name"],
        productLink: json["Product_link"],
        quantity: json["Quantity"],
        rating: json["Rating"],
    );

    Map<String, dynamic> toJson() => {
        "Average star": averageStar,
        "Discount": discount,
        "MRP": mrp,
        "Price": price,
        "Product Name": productName,
        "Product_link": productLink,
        "Quantity": quantity,
        "Rating": rating,
    };
}
