import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/models/category.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/repositories/category_repository.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  final _productsService = locator<ProductRepository>();
  final _categoryService = locator<CategoryRepository>();
  final _navigationService = locator<NavigationService>();

  Map<String, List<Product>> productSections = {
    "featured": [],
    "on-sale": [],
    "latest": [],
  };
  List<Category> categories = [];

  navigateToSearch() {
    _navigationService.navigateToSearchView();
  }

  viewMore(String title) {
    Map<String, ProductQueryParams> params = {
      "Featured Products": ProductQueryParams(featured: true),
      "Sale Products": ProductQueryParams(featured: true),
      "Latest Products": ProductQueryParams(),
    };

    _navigationService.navigateToProductsView(
      productParameters: params[title] ?? ProductQueryParams(),
    );
  }

  @override
  Future futureToRun() async {
    var categoriesResponse = await _categoryService.fetchAllCategories();

    categoriesResponse.fold(
      (l) {
        throw l;
      },
      (r) {
        categories.addAll(r.where((c) => c.parent == 0));
      },
    );

    var featuredProducts = await _productsService
        .fetchProducts(1, ProductQueryParams(featured: true), perPage: 5);
    featuredProducts.fold(
        (l) {}, (r) => productSections["featured"]!.addAll(r));

    var onsaleProducts = await _productsService
        .fetchProducts(1, ProductQueryParams(onsale: true), perPage: 5);
    onsaleProducts.fold((l) {}, (r) => productSections["on-sale"]!.addAll(r));

    var latestProducts =
        await _productsService.fetchProducts(1, ProductQueryParams());
    latestProducts.fold((l) {}, (r) => productSections["latest"]!.addAll(r));
  }
}
