import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/models/product_variation.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/product_details/product_details_viewmodel.dart';
import 'package:flucommerce/ui/widgets/common/variable_product_sheet/variable_product_sheet.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GroupedProducts extends StatelessWidget {
  const GroupedProducts({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    // var localization = AppLocalizations.of(context)!;
    var model =
        getParentViewModel<ProductDetailsViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          "localization.products_collection",
          style: Theme.of(context).textTheme.headlineSmall!,
        ),
        verticalSpaceTiny,
        for (var i = 0; i < products.length; i++)
          Builder(
            builder: (context) {
              var product = products[i];
              ProductVariation? variation =
                  model.selectedVariations[product.id];
              String? image = product.images.firstOrNull;
              var price = "";
              if (product.type == ProductType.variable) {
                price = variation?.price ?? "";
              } else {
                price = product.price;
              }

              return GestureDetector(
                onTap: () async {
                  if (product.type == ProductType.variable) {
                    var result = await showModalBottomSheet(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return VariableProductSheet(product);
                      },
                    );
                    if (result != null) {
                      model.selectVariation(product.id, result);
                    }
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  height: screenWidth(context) * .25,
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: kcSecondaryColor,
                        height: screenWidth(context) * .25,
                        width: screenWidth(context) * .25,
                        child: variation?.image != null
                            ? Image.network(variation!.image!)
                            : image != null
                                ? Image.network(image)
                                : const ResponsiveIcon(Icons.image),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ResponsiveText(
                                  product.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium!,
                                ),
                                verticalSpaceTiny,
                                ResponsiveText(
                                  "$price\$",
                                  style:
                                      Theme.of(context).textTheme.titleMedium!,
                                ),
                              ],
                            ),
                            if (product.type == ProductType.variable)
                              Container(
                                decoration: BoxDecoration(
                                  color: kcSecondaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ResponsiveText(
                                    variation == null
                                        ? "select variation"
                                        : variation.attributes
                                            .map((e) => e.option)
                                            .join(' - '),
                                    style:
                                        Theme.of(context).textTheme.titleSmall!,
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        // if (selectedVariation.length != variableProducts.length &&
        //     variableProducts.isNotEmpty)
        //   MessageAlert(
        //     message: localization.unselected_variation_message(
        //         "( $notSelectedVariableProducts )"),
        //   )
      ],
    );
  }
}
