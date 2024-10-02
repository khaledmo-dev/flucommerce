import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:stacked/stacked.dart';
import 'search_view.form.dart';

class SearchViewModel extends FormViewModel {
  final _productRepository = locator<ProductRepository>();
  var logger = getLogger("SearchViewModel");

  int currentPage = 1;

  bool _isFilterEnabled = false;
  bool get isFilterEnabled => _isFilterEnabled;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  ProductQueryParams _parameters = ProductQueryParams();

  ProductQueryParams get parameters => _parameters;

  bool get objectBusy => busy(this);

  List<Product> products = [];

  clearParameters() {
    _parameters = ProductQueryParams(searchTerm: _parameters.searchTerm);
    _isFilterEnabled = false;
    products.clear();
    _hasMore = true;
    currentPage = 1;
    fetchProducts();
  }

  applyParameters(ProductQueryParams parameters) {
    _parameters = parameters;
    _isFilterEnabled = true;
    products.clear();
    _hasMore = true;
    currentPage = 1;
    fetchProducts();
  }

  fetchProducts() async {
    // if query does not equal current controller value then it is a new search,
    // so reset products list and page number
    if (_parameters.searchTerm != searchValue) {
      _parameters = _parameters.copyWith(searchTerm: searchValue);
      products.clear();
      _hasMore = true;
      currentPage = 1;
    }

    // prevent the query if there is no more products or if the view model is busy
    if (!_hasMore || anyObjectsBusy) return;

    // prevent the query if controller text  is empty
    // if (searchValue == null || searchValue!.isEmpty) {
    //   setSearchValidationMessage("Start typing to search");
    //   rebuildUi();
    //   return;
    // }
    if (products.isNotEmpty) {
      setBusyForObject('paginate', true);
    } else {
      setBusy(true);
    }

    var response = await _productRepository.fetchProducts(
      currentPage,
      _isFilterEnabled
          ? parameters
          : ProductQueryParams(searchTerm: searchValue),
    );
    response.fold(
      (l) {
        setError(l);
      },
      (r) {
        if (r.length < 10) {
          _hasMore = false;
        }
        products.addAll(r);
        currentPage++;
      },
    );
    setBusyForObject('paginate', false);
    setBusy(false);
  }
}
