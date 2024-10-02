import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../data/models/category.dart';

class CategoryGridModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  navigateToCategoryProducts(Category category) {
    _navigationService.navigateToCategoryDetailsView(category: category);
  }
}
