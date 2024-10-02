import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/data/models/category.dart';
import 'package:flucommerce/data/repositories/category_repository.dart';
import 'package:stacked/stacked.dart';

class CategoriesViewModel extends FutureViewModel {
  final _categoryRepository = locator<CategoryRepository>();

  @override
  Future<List<Category>> futureToRun() async {
    var response = await _categoryRepository.fetchAllCategories();
    return response.fold(
      (l) {
        throw l;
      },
      (r) {
        return r;
      },
    );
  }
}
