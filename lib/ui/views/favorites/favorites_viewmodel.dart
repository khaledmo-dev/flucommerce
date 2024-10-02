import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/repositories/favorite_repository.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _productRepository = locator<ProductRepository>();
  final _favoriteRepository = locator<FavoriteRepository>();

  ValueListenable<Box<Favorite>> get favoriteListenable =>
      Hive.box<Favorite>(favoriteBoxKey).listenable();

  removeFavorite(Favorite product) {
    _favoriteRepository.changeFavoriteStatus(product);
  }

  navigateToProductDetails(int id) async {
    setBusy(true);
    var response = await _productRepository.fetchSingleProduct(id);
    setBusy(false);

    response.fold(
      (l) {},
      (r) {
        _navigationService.navigateToProductDetailsView(product: r);
      },
    );
  }
}
