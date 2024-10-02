import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/data/models/order.dart';
import 'package:flucommerce/data/repositories/order_repository.dart';
import 'package:stacked/stacked.dart';

class OrdersViewModel extends FutureViewModel {
  final _ordersRepository = locator<OrderRepository>();

  int currentPage = 1;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  bool get objectBusy => busy(this);

  List<Order> orders = [];

  fetchOrders() async {
    if (!_hasMore || busy('paginate')) return;

    setBusyForObject('paginate', true);
    var response = await _ordersRepository.fetchOrders(currentPage);
    response.fold(
      (l) {
        setError(l);
      },
      (r) {
        if (r.length < 10) {
          _hasMore = false;
        }
        orders.addAll(r);
        currentPage++;
      },
    );
    setBusyForObject('paginate', false);
  }

  @override
  Future futureToRun() async {
    setBusy(true);
    await fetchOrders();
    setBusy(false);
  }
}
