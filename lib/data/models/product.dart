import 'package:flucommerce/services/hive_db.dart';
import 'package:html_unescape/html_unescape.dart';

List<Product> productFromJson(List list) =>
    List<Product>.from(list.map((x) => Product.fromJson(x)));

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.type,
    required this.featured,
    required this.description,
    required this.price,
    required this.htmlPrice,
    required this.regularPrice,
    required this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    required this.onSale,
    required this.totalSales,
    this.stockQuantity,
    required this.stockStatus,
    required this.groupedProducts,
    required this.backordersAllowed,
    required this.weight,
    required this.dimensions,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.relatedIds,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.categories,
    required this.images,
    required this.defaultAttributes,
    required this.externalUrl,
    required this.buttonText,
  });

  final int id;
  final String name;
  final String slug;
  final String permalink;
  final ProductType type;

  final bool featured;

  final String description;

  final String price;
  final String htmlPrice;
  final String regularPrice;
  final String salePrice;
  final dynamic dateOnSaleFrom;
  final dynamic dateOnSaleTo;
  final bool onSale;

  final int totalSales;

  final dynamic stockQuantity;
  final String stockStatus;

  final bool backordersAllowed;

  final String weight;
  final Dimensions dimensions;

  final bool reviewsAllowed;
  final String averageRating;
  final int ratingCount;
  final List<int> relatedIds;
  final List<dynamic> upsellIds;
  final List<dynamic> crossSellIds;
  final int parentId;

  final List<CategoryRef> categories;

  final List<dynamic> groupedProducts;

  final List<String> images;

  final List<dynamic> defaultAttributes;

  final String externalUrl;
  final String buttonText;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      permalink: json["permalink"],
      type: getProductType(json["type"]),
      featured: json["featured"],
      description: json["description"],
      price: json["price"],
      htmlPrice: formatHtmlPrice(json['price_html']),
      regularPrice: json["regular_price"],
      salePrice: json["sale_price"],
      dateOnSaleFrom: json["date_on_sale_from"],
      dateOnSaleTo: json["date_on_sale_to"],
      onSale: json["on_sale"],
      totalSales: json["total_sales"] is String
          ? int.parse(json["total_sales"])
          : json["total_sales"],
      stockQuantity: json["stock_quantity"],
      stockStatus: json["stock_status"],
      backordersAllowed: json["backorders_allowed"],
      weight: json["weight"],
      dimensions: Dimensions.fromJson(json["dimensions"]),
      groupedProducts:
          List<dynamic>.from(json["grouped_products"].map((x) => x)),
      reviewsAllowed: json["reviews_allowed"],
      averageRating: json["average_rating"],
      ratingCount: json["rating_count"],
      relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
      upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
      crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
      parentId: json["parent_id"],
      categories: List<CategoryRef>.from(
          json["categories"].map((x) => CategoryRef.fromJson(x))),
      images: List<String>.from(json["images"].map((x) => x['src'])),
      defaultAttributes:
          List<dynamic>.from(json["default_attributes"].map((x) => x)),
      externalUrl: json['external_url'],
      buttonText: json['button_text'],
    );
  }

  CartItem cartItem(int quantity) {
    return CartItem(
        productID: id,
        quantity: quantity,
        productName: name,
        image: images.firstOrNull ?? "",
        productPrice: price);
  }
}

class CategoryRef {
  CategoryRef({
    required this.id,
    required this.name,
    required this.slug,
  });

  final int id;
  final String name;
  final String slug;

  factory CategoryRef.fromJson(Map<String, dynamic> json) => CategoryRef(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
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

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );
}

enum ProductType {
  simple,
  grouped,
  external,
  variable,
}

ProductType getProductType(String type) {
  switch (type) {
    case 'simple':
      return ProductType.simple;
    case 'grouped':
      return ProductType.grouped;
    case 'external':
      return ProductType.external;
    case 'variable':
      return ProductType.variable;
    default:
      return ProductType.simple;
  }
}

String formatHtmlPrice(String htmlPrice) {
  String result = '';
  RegExp regExp = RegExp(r'(?<=\>)(.*?)(?=\<)');
  var matchess = regExp.allMatches(htmlPrice);
  for (var match in matchess) {
    result += match.group(0)!;
  }

  return HtmlUnescape().convert(result);
}
