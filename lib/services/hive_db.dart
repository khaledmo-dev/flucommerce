import 'package:hive/hive.dart';

part 'hive_db.g.dart';

const String favoriteBoxKey = "favorite";
const String cartBoxKey = "cart";
const String orderBoxKey = "order";

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  final int productID;

  @HiveField(1)
  final int? variationID;

  @HiveField(6)
  final String? variationTitle;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final String productPrice;

  @HiveField(4)
  final String productName;

  @HiveField(5)
  final String? image;

  CartItem({
    required this.productID,
    this.variationID,
    this.variationTitle,
    required this.quantity,
    this.productPrice = '0',
    required this.productName,
    required this.image,
  });

  CartItem copyWith({
    int? productID,
    int? variationID,
    String? variationTitle,
    int? quantity,
    String? image,
    String? productName,
    String? productPrice,
  }) =>
      CartItem(
        productID: productID ?? this.productID,
        variationTitle: variationTitle ?? this.variationTitle,
        variationID: variationID ?? this.variationID,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        productName: productName ?? this.productName,
        productPrice: productPrice ?? this.productPrice,
      );
}

@HiveType(typeId: 1)
class Favorite extends HiveObject {
  @HiveField(0)
  final int productID;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String? image;

  Favorite({
    required this.productID,
    required this.productName,
    required this.image,
  });
}
