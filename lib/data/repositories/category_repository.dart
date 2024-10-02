import 'package:dartz/dartz.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/consts.dart';
import 'package:flucommerce/data/models/category.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/services/client_service.dart';

abstract class CategoryRepository {
  Future<Either<AppException, List<Product>>> fetchCategoryProducts(
      int categoryID, int page);
  Future<Either<AppException, List<Category>>> fetchAllCategories();

  late List<Category> categories;
}

class CategoryRepositoryImpl implements CategoryRepository {
  final _client = locator<ClientService>();

  var logger = getLogger("CategoryRepositoryImpl");

  @override
  List<Category> categories = [];

  @override
  Future<Either<AppException, List<Category>>> fetchAllCategories() async {
    try {
      if (categories.isNotEmpty) {
        return Right(categories);
      }

      var response =
          await _client.get(api: "${AppConstants.categoryUrl}?per_page=100");

      var result = categoryFromJson(response);

      if (categories.isEmpty) {
        categories.addAll(result);
      }

      logger.d(result);
      return Right(result);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<Product>>> fetchCategoryProducts(
      int categoryID, int page) async {
    try {
      final stopwatch = Stopwatch()..start();

      var response = await _client.get(
        api: "${AppConstants.productUrl}?category=$categoryID&page=$page",
      );

      var result = productFromJson(response);

      logger.d(result);

      logger.wtf('function executed in ${stopwatch.elapsed}');

      stopwatch.stop();
      return Right(result);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }
}
