import 'package:carousel_slider/carousel_controller.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/models/product_variation.dart';
import 'package:flucommerce/data/repositories/cart_repository.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:flucommerce/services/hive_db.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsViewModel extends FutureViewModel {
  final Product product;
  ProductDetailsViewModel(this.product);

  final _productRepository = locator<ProductRepository>();
  final _cartRepository = locator<CartRepository>();
  var logger = getLogger("ProductDetailsViewModel");

  int quantity = 1;
  String price = "0";

  List<String> images = [];

  // if product type is variable
  Map<ProductVariation, List<String>> combinations = {};
  Map<String, Set<String>> attributes = {};
  // ------------------------------

  // if product type is grouped
  final List<Product> groupedProducts = [];
  // ------------------------------

  final CarouselSliderController imagesController = CarouselSliderController();

  // selectedVariations is used for variable products wether the main product is variable,
  // or the main product contains a variable product
  // mapping product ID to variation
  Map<int, ProductVariation?> selectedVariations = {};

  increaseQuantity() {
    quantity++;
    _setPrice();
    rebuildUi();
  }

  decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      _setPrice();
      rebuildUi();
    }
  }

  selectVariation(int productID, ProductVariation? variation) {
    selectedVariations[productID] = variation;
    _setPrice();

    var image = variation?.image;
    if (image != null && product.type == ProductType.variable) {
      if (!images.contains(image)) {
        images.add(image);
      }
      int index = images.indexOf(image);
      Future.delayed(const Duration(milliseconds: 500));
      imagesController.animateToPage(index);
    }
    rebuildUi();
  }

  confirm() {
    switch (product.type) {
      case ProductType.simple:
        _cartRepository.addCartItem(product.cartItem(quantity));
      case ProductType.grouped:
        List<CartItem> items = [];

        for (var p in groupedProducts) {
          if (p.type == ProductType.variable) {
            var item = selectedVariations[p.id]?.cartItem(quantity, p.name);
            if (item == null) {
              logger.w("You have to select variation for variable products");
              return;
            }
            items.add(item);
          } else {
            items.add(p.cartItem(quantity));
          }
        }

        for (var item in items) {
          _cartRepository.addCartItem(item);
        }

      case ProductType.external:
        launchUrl(Uri.parse(product.externalUrl));

      case ProductType.variable:
        var item =
            selectedVariations[product.id]?.cartItem(quantity, product.name);
        if (item == null) {
          logger.e("pick a variation first");
          return;
        }
        _cartRepository.addCartItem(item);
    }
  }

  @override
  Future futureToRun() async {
    images.addAll(product.images);
    if (product.type == ProductType.variable) {
      var response =
          await _productRepository.fetchProductVariations(product.id);
      response.fold(
        (l) {
          throw l;
        },
        (r) {
          var result = _possibleCombinations(r);
          combinations = result.combinations;
          attributes = result.attribute;
        },
      );
    } else if (product.type == ProductType.grouped) {
      var response = await _productRepository
          .fetchGroupedProducts(product.groupedProducts);
      response.fold(
        (l) {
          throw l;
        },
        (r) {
          groupedProducts.addAll(r);
        },
      );
    }
    _setPrice();
  }

  _setPrice() {
    switch (product.type) {
      case ProductType.simple:
        price = _formatPrice(product.price, quantity);
      case ProductType.grouped:
        double totalPrice = 0;
        for (var element in groupedProducts) {
          if (element.type == ProductType.variable) {
            totalPrice +=
                double.tryParse(selectedVariations[element.id]?.price ?? '') ??
                    0.0;
          } else {
            totalPrice += double.tryParse(element.price) ?? 0;
          }
        }
        logger.wtf(totalPrice);
        price = _formatPrice(totalPrice.toString(), quantity);
      case ProductType.external:
        price = _formatPrice(product.price, quantity);

      case ProductType.variable:
        var variation = selectedVariations[product.id];
        if (variation != null) {
          price = _formatPrice(variation.price, quantity);
        } else {
          price = "";
        }
    }
  }
}

String _formatPrice(String price, int quantity) {
  double? parsedPrice = double.tryParse(price);
  if (parsedPrice == null) {
    return "";
  } else {
    return (quantity * parsedPrice).toStringAsFixed(1);
  }
}

({
  Map<ProductVariation, List<String>> combinations,
  Map<String, Set<String>> attribute
}) _possibleCombinations(List<ProductVariation> variations) {
  Map<ProductVariation, List<String>> combinations = {};
  Map<String, Set<String>> attributes = {};

  for (var e in variations) {
    e.attributes.map((e) => e.option).toList();
    combinations[e] = e.attributes.map((e) {
      if (!attributes.containsKey(e.name)) {
        attributes[e.name] = {e.option};
      } else {
        attributes[e.name]!.add(e.option);
      }

      return e.option;
    }).toList();
  }

  return (combinations: combinations, attribute: attributes);
}
