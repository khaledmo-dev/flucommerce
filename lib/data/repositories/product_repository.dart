import 'package:dartz/dartz.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/consts.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/models/product_variation.dart';
import 'package:flucommerce/services/client_service.dart';

abstract class ProductRepository {
  Future<Either<AppException, List<Product>>> fetchGroupedProducts(
      List productsIDs);
  Future<Either<AppException, List<ProductVariation>>> fetchProductVariations(
      int productID);
  Future<Either<AppException, Product>> fetchSingleProduct(int productID);

  Future<Either<AppException, List<Product>>> fetchProducts(
      int page, ProductQueryParams parameters,
      {int perPage});
}

class ProductRepositoryImpl implements ProductRepository {
  final _client = locator<ClientService>();

  final logger = getLogger("ProductRepositoryImpl");

  @override
  Future<Either<AppException, List<Product>>> fetchGroupedProducts(
      List productsIDs) async {
    var include = productsIDs.join(",");
    try {
      var response =
          await _client.get(api: "${AppConstants.productUrl}?include=$include");

      var result = productFromJson(response);
      logger.wtf(result);
      return Right(result);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<ProductVariation>>> fetchProductVariations(
      int productID) async {
    try {
      final stopwatch = Stopwatch()..start();

      var response = await _client.get(
        api: "${AppConstants.productUrl}/$productID/variations?per_page=100",
      );

      var result = productVariationFromJson(response);

      logger.w('function executed in ${stopwatch.elapsed}');

      stopwatch.stop();

      return Right(result);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<Product>>> fetchProducts(
      int page, ProductQueryParams parameters,
      {int perPage = 10}) async {
    try {
      var response = await _client.get(
          api:
              "${AppConstants.productUrl}?per_page=$perPage&page=$page&${parameters.getQueryParameters()}");

      var result = productFromJson(response);
      logger.d(result);
      return Right(result);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }

  @override
  Future<Either<AppException, Product>> fetchSingleProduct(
      int productID) async {
    try {
      var response =
          await _client.get(api: "${AppConstants.productUrl}/$productID");
      var result = Product.fromJson(response);

      return Right(result);
    } catch (e) {
      logger.e(e);
      return Left(AppException(body: e.toString()));
    }
  }
}

class ProductQueryParams {
  final String? searchTerm;
  final bool? featured;
  final bool? onsale;
  final String? orderBy;
  final String? minPrice;
  final String? maxPrice;
  final String? categoryID;

  ProductQueryParams({
    this.searchTerm,
    this.featured,
    this.onsale,
    this.orderBy,
    this.minPrice,
    this.maxPrice,
    this.categoryID,
  });

  ProductQueryParams copyWith({
    String? searchTerm,
    bool? featured,
    bool? onsale,
    String? orderBy,
    String? minPrice,
    String? maxPrice,
    String? categoryID,
  }) =>
      ProductQueryParams(
        searchTerm: searchTerm ?? this.searchTerm,
        featured: featured ?? this.featured,
        onsale: onsale ?? this.onsale,
        orderBy: orderBy ?? this.orderBy,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        categoryID: categoryID ?? this.categoryID,
      );

  String getQueryParameters() {
    String params = "";

    if (searchTerm != null) {
      params += "&search=$searchTerm&search_columns=post_title";
    }
    if (featured != null) {
      params += "&features=$featured";
    }
    if (onsale != null) {
      params += "&on_sale=$onsale";
    }
    if (orderBy != null) {
      params += "&orderby=$orderBy";
    }
    if (minPrice != null) {
      params += "&min_price=$minPrice";
    }
    if (maxPrice != null) {
      params += "&max_price=$maxPrice";
    }
    if (categoryID != null) {
      params += "&category=$categoryID";
    }

    return params;
  }
}
