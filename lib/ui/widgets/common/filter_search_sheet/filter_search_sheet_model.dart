import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:stacked/stacked.dart';

class FilterSearchSheetModel extends BaseViewModel {
  ProductQueryParams _parameters = ProductQueryParams();

  ProductQueryParams get parameters => _parameters;

  syncParameters(ProductQueryParams parameters) {
    _parameters = parameters;
    rebuildUi();
  }

  // clearParameters() {
  //   _parameters = ProductQueryParams(searchTerm: _parameters.searchTerm);
  // }

  updatePriceRange({double? minPrice, double? maxPrice}) {
    _parameters = _parameters.copyWith(
      minPrice: minPrice.toString(),
      maxPrice: maxPrice.toString(),
    );
    rebuildUi();
  }

  updateOrderby(String? e) {
    _parameters = _parameters.copyWith(orderBy: e);
    rebuildUi();
  }
}
