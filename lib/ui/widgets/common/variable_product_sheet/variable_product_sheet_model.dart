import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/models/product_variation.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:stacked/stacked.dart';

class VariableProductSheetModel extends FutureViewModel {
  final Product product;
  VariableProductSheetModel(this.product);

  final _productRepository = locator<ProductRepository>();

  ProductVariation? selectedVariation;

  selectVariation(ProductVariation variation) {
    selectedVariation = variation;
    rebuildUi();
  }

  Map<ProductVariation, List<String>> combinations = {};
  Map<String, Set<String>> attributes = {};

  @override
  Future futureToRun() async {
    var response = await _productRepository.fetchProductVariations(product.id);
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
