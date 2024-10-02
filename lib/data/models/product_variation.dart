import 'package:flucommerce/services/hive_db.dart';

List<ProductVariation> productVariationFromJson(List list) =>
    List<ProductVariation>.from(list.map((x) => ProductVariation.fromJson(x)));

class ProductVariation {
  ProductVariation({
    required this.id,
    required this.parentID,
    required this.description,
    required this.permalink,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    required this.onSale,
    this.stockQuantity,
    required this.stockStatus,
    required this.backordersAllowed,
    required this.weight,
    required this.dimensions,
    required this.image,
    required this.attributes,
  });

  final int id;
  final int parentID;
  final String description;
  final String permalink;
  final String price;
  final String regularPrice;
  final String salePrice;
  final dynamic dateOnSaleFrom;
  final dynamic dateOnSaleTo;
  final bool onSale;
  final String stockStatus;

  final dynamic stockQuantity;

  final bool backordersAllowed;

  final String weight;
  final Dimensions dimensions;

  final String? image;
  final List<Attribute> attributes;

  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      ProductVariation(
        id: json["id"],
        parentID: json["parent_id"],
        description: json["description"],
        permalink: json["permalink"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleTo: json["date_on_sale_to"],
        onSale: json["on_sale"],
        stockQuantity: json["stock_quantity"],
        backordersAllowed: json["backorders_allowed"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        image: json["image"] == null ? null : json["image"]['src'],
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        stockStatus: json["stock_status"],
      );

  CartItem cartItem(int quantity, String productName) {
    return CartItem(
        productID: id,
        quantity: quantity,
        productName: productName,
        variationTitle:
            attributes.map((e) => "${e.name}: ${e.option}").join(" | "),
        image: image ?? "",
        productPrice: price);
  }
}

class Attribute {
  const Attribute({
    required this.id,
    required this.name,
    required this.option,
  });

  final int id;
  final String name;
  final String option;

  Attribute copyWith({
    int? id,
    String? name,
    String? option,
  }) =>
      Attribute(
        id: id ?? this.id,
        name: name ?? this.name,
        option: option ?? this.option,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        option: json["option"],
      );
}

class Dimensions {
  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  final String length;
  final String width;
  final String height;

  Dimensions copyWith({
    String? length,
    String? width,
    String? height,
  }) =>
      Dimensions(
        length: length ?? this.length,
        width: width ?? this.width,
        height: height ?? this.height,
      );

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );
}
