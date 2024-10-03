import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/data/models/category.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/repositories/category_repository.dart';
import 'package:stacked/stacked.dart';

class CategoryDetailsViewModel extends FutureViewModel {
  final Category category;
  CategoryDetailsViewModel(this.category);

  final _categoryRepository = locator<CategoryRepository>();

  int currentPage = 1;

  bool _hasMore = true;

  bool get hasMore => _hasMore;

  bool get objectBusy => busy(this);

  List<Product> products = [];

  List<Category> subCategories = [];

  fetchProducts() async {
    if (!_hasMore || busy('paginate')) return;

    setBusyForObject('paginate', true);
    var response = await _categoryRepository.fetchCategoryProducts(
      category.id,
      currentPage,
    );
    response.fold(
      (l) {
        if (currentPage == 1) {
          setError(l);
        } else {
          setErrorForObject("paginate", error);
        }
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
  }

  @override
  Future futureToRun() async {
    var categories = _categoryRepository.categories;
    subCategories.addAll(categories.where((c) => c.parent == category.id));
    await fetchProducts();
  }
}
