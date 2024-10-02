import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/consts.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:flucommerce/data/repositories/cart_repository.dart';
import 'package:flucommerce/data/repositories/order_repository.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/ui/views/orders/widgets/order_success_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckoutViewModel extends BaseViewModel {
  final List<CartItem> items;
  CheckoutViewModel(this.items);

  final _cartRepository = locator<CartRepository>();
  final _orderRepository = locator<OrderRepository>();

  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();

  String initialUrl() {
    var token = _authRepository.authToken();
    // ignore: prefer_adjacent_string_concatenation
    return "${AppConstants.baseUrl}/checkout?" +
        "token=$token" +
        _productsUrl();
  }

  onOrderPlaced(String orderID) {
    if (_authRepository.isGuest()) {
      _orderRepository.addGuestOrder(orderID);
    }
    _cartRepository.clearCartItems();
    _navigationService.back();

    _navigationService.navigateToView(OrderSuccessScreen(orderID));
  }

  String _productsUrl() {
    String urlItems = '';
    for (var element in items) {
      if (element.variationID != null) {
        urlItems += ",${element.variationID}:${element.quantity}";
      } else {
        urlItems += ",${element.productID}:${element.quantity}";
      }
    }
    return "&products=$urlItems";
  }
}
