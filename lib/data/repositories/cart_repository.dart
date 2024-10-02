import 'package:dartz/dartz.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/consts.dart';
import 'package:flucommerce/services/client_service.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked_annotations.dart';

abstract class CartRepository implements InitializableDependency {
  Future<Either<AppException, List<CartItem>>> getCartItems();

  Future clearCartItems();

  Future addCartItem(CartItem cartItem);

  Future removeCartItem(CartItem cartItem);

  Future updateCartItem(CartItem cartItem);
}

class CartRepositoryImpl implements CartRepository {
  @override
  Future<void> init() async {
    cartBox = await Hive.openBox(cartBoxKey);
  }

  late Box<CartItem> cartBox;

  final _client = locator<ClientService>();

  var logger = getLogger("CartRepositoryImpl");

  @override
  Future addCartItem(CartItem cartItem) async {
    late String key;
    if (cartItem.variationID != null) {
      key = "${cartItem.productID}:${cartItem.variationID}";
    } else {
      key = cartItem.productID.toString();
    }

    if (cartBox.containsKey(key)) {
      CartItem oldCartItem = cartBox.get(key)!;
      await cartBox.put(
        key,
        oldCartItem.copyWith(
          quantity: oldCartItem.quantity + cartItem.quantity,
        ),
      );
    } else {
      await cartBox.put(key, cartItem);
    }
  }

  @override
  Future clearCartItems() async {
    await cartBox.clear();
  }

  @override
  Future<Either<AppException, List<CartItem>>> getCartItems() async {
    try {
      // This function is there to make sure that the price stay of the cart item is the same price in the store
      // for example if the price of the product increased in the main website but the product has been in the cart for a long time this can cause difference in prices
      // between the app and the website thus creates issues
      final stopwatch = Stopwatch()..start();

      List<CartItem> cartItems = [];

      List<Future> futures = cartBox.values.map(
        (cartItem) {
          var productID = cartItem.productID;
          if (cartItem.variationID != null) {
            return _client.get(
              api:
                  "${AppConstants.variationUrl(productID)}/${cartItem.variationID}",
            );
          } else {
            return _client.get(api: "${AppConstants.productUrl}/$productID");
          }
        },
      ).toList();

      var results = await Future.wait(futures);

      for (var i = 0; i < cartBox.length; i++) {
        late String productPrice;

        var cartItem = cartBox.values.toList()[i];

        if (cartItem.variationID != null) {
          productPrice = results[i]['price'].toString();
          cartBox.put(
            "${cartItem.productID}:${cartItem.variationID}",
            cartItem.copyWith(
              productPrice: productPrice,
            ),
          );
        } else {
          productPrice = results[i]['price'].toString();
          cartBox.put(
            cartItem.productID.toString(),
            cartItem.copyWith(
              productPrice: productPrice,
            ),
          );
        }

        cartItems.add(
          cartItem.copyWith(
            productPrice: productPrice,
          ),
        );
      }

      logger.wtf('function executed in ${stopwatch.elapsed}');

      stopwatch.stop();

      return Right(cartItems);
    } catch (e) {
      logger.wtf(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future removeCartItem(CartItem cartItem) async {
    late String key;
    if (cartItem.variationID != null) {
      // This deals with variable products
      key = "${cartItem.productID}:${cartItem.variationID}";
    } else {
      key = cartItem.productID.toString();
    }

    await cartBox.delete(key);
  }

  @override
  Future updateCartItem(CartItem cartItem) async {
    late String key;
    if (cartItem.variationID != null) {
      // This deals with variable products
      key = "${cartItem.productID}:${cartItem.variationID}";
    } else {
      key = cartItem.productID.toString();
    }

    await cartBox.put(key, cartItem);
  }
}
