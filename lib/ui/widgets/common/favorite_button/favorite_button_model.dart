import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/repositories/favorite_repository.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:stacked/stacked.dart';

class FavoriteButtonModel extends BaseViewModel {
  final Product product;
  FavoriteButtonModel(this.product);

  final _favoriteRepository = locator<FavoriteRepository>();

  late bool isFavorited = _favoriteRepository.isFavorited(product.id);

  toggleFavoriteStatus() {
    _favoriteRepository.changeFavoriteStatus(
      Favorite(
        productID: product.id,
        productName: product.name,
        image: product.images.firstOrNull,
      ),
    );

    isFavorited = !isFavorited;
    rebuildUi();
  }
}
