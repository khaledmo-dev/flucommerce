import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:stacked/stacked.dart';

class ProductsViewModel extends FutureViewModel {
  final ProductQueryParams parameters;
  ProductsViewModel(this.parameters);

  final _productRepository = locator<ProductRepository>();

  int currentPage = 1;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  bool get objectBusy => busy(this);

  List<Product> products = [];

  fetchProducts() async {
    if (!_hasMore || busy('paginate')) return;

    setBusyForObject('paginate', true);
    var response = await _productRepository
        .fetchProducts(currentPage, parameters, perPage: 9);
    response.fold(
      (l) {
        setError(l);
      },
      (r) {
        if (r.length < 9) {
          _hasMore = false;
        }
        products.addAll(r);
        currentPage++;
      },
    );
    setBusyForObject('paginate', false);
  }

  @override
  Future futureToRun() async {
    await fetchProducts();
  }
}
