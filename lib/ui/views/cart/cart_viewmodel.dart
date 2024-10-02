import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:flucommerce/data/repositories/cart_repository.dart';
import 'package:flucommerce/services/flash_message_service.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _cartRepository = locator<CartRepository>();
  final _authRepository = locator<AuthRepository>();
  final _flashMessageService = locator<FlashMessageService>();
  final logger = getLogger("CartViewModel");

  ValueListenable<Box<CartItem>> get cartListenable =>
      Hive.box<CartItem>(cartBoxKey).listenable();

  void deleteItem(CartItem item) {
    _cartRepository.removeCartItem(item);
  }

  increaseQuantity(CartItem item) {
    _cartRepository.updateCartItem(item.copyWith(quantity: item.quantity + 1));
  }

  decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      _cartRepository
          .updateCartItem(item.copyWith(quantity: item.quantity - 1));
    }
  }

  void checkout(List<CartItem> items) async {
    if (items.isEmpty) {
      _flashMessageService.showMessage(
        title: "empty_cart_message".translate(),
        message: "cant_checkout_message".translate(),
        type: FlashMessageType.warning,
      );
      return;
    }
    var response = await _authRepository.validateToken();
    response.fold(
      (l) {
        if (l.body == "NO-TOKEN") {
          _flashMessageService.showMessage(
            title: "login_first".translate(),
            message: "login_required_for_checkout".translate(),
            type: FlashMessageType.warning,
          );
          return;
        }

        _authRepository.logout();

        _navigationService.replaceWithLoginView();
        _flashMessageService.showMessage(
          title: "session_expired".translate(),
          message: "login_again_to_continue".translate(),
          type: FlashMessageType.warning,
        );

        logger.e(l);
      },
      (r) {
        _navigationService.navigateToCheckoutView(items: items);
      },
    );
  }

  @override
  Future futureToRun() async {
    await _cartRepository.getCartItems();
  }
}
