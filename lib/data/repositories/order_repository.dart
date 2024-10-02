import 'package:dartz/dartz.dart' hide Order;
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/consts.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:flucommerce/services/client_service.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked_annotations.dart';
import 'dart:convert';
import '../models/order.dart';

abstract class OrderRepository implements InitializableDependency {
  Future<Either<AppException, List<Order>>> fetchOrders(int page);
  Future<Either<AppException, Unit>> updateOrder(String id);
  void addGuestOrder(String orderID);
}

class OrderRepositoryImpl implements OrderRepository {
  late Box<String> ordersBox;

  @override
  Future<void> init() async {
    ordersBox = await Hive.openBox(orderBoxKey);
  }

  final _client = locator<ClientService>();
  final _authRepository = locator<AuthRepository>();

  var logger = getLogger("OrdersRepositoryImpl");

  @override
  Future<Either<AppException, List<Order>>> fetchOrders(int page) async {
    try {
      var user = _authRepository.getSignedInUser();
      //if the user is signed in get his orders
      if (user != null) {
        var response = await _client.get(
          api:
              "${AppConstants.orderUrl}?customer=${user.id}&page=$page&status=pending,processing,on-hold,completed,cancelled,refunded,failed",
        );

        var orders = ordersFromJson(response);
        return Right(orders);
      }

      // else if he is not get the orders that are stored locally
      else {
        var include = ordersBox.values.skip((page - 1) * 5).take(5).join(",");

        var response =
            await _client.get(api: "${AppConstants.orderUrl}?include=$include");

        var orders = ordersFromJson(response);
        return Right(orders);
      }
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> updateOrder(String id) async {
    var user = _authRepository.getSignedInUser();

    if (user == null) {
      return const Right(unit);
    }
    try {
      var response = await _client.put(
        api: "${AppConstants.orderUrl}/$id",
        body: json.encode({"customer_id": user.id}),
      );

      logger.wtf(response);

      return const Right(unit);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  void addGuestOrder(String orderID) {
    ordersBox.add(orderID);
  }
}
