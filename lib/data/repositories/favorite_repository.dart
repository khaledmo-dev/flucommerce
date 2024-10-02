import 'package:flucommerce/services/hive_db.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked_annotations.dart';

abstract class FavoriteRepository implements InitializableDependency {
  void changeFavoriteStatus(Favorite product);
  bool isFavorited(int productID);
  List<Favorite> getFavoriteProducts();
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  late Box<Favorite> favoritesBox;

  @override
  Future<void> init() async {
    favoritesBox = await Hive.openBox(favoriteBoxKey);
  }

  @override
  void changeFavoriteStatus(Favorite product) {
    int productID = product.productID;
    if (favoritesBox.containsKey(productID)) {
      favoritesBox.delete(productID);
    } else {
      favoritesBox.put(productID, product);
    }
  }

  @override
  bool isFavorited(int productID) {
    return favoritesBox.containsKey(productID);
  }

  @override
  List<Favorite> getFavoriteProducts() {
    return favoritesBox.values.toList();
  }
}
