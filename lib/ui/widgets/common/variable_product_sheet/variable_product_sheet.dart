import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/data/models/product_variation.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/widgets/common/attributes_section/attributes_section.dart';
import 'package:flucommerce/ui/widgets/common/image_section/image_section.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'variable_product_sheet_model.dart';

class VariableProductSheet extends StackedView<VariableProductSheetModel> {
  const VariableProductSheet(this.product, {super.key, this.selectedVariation});
  final Product product;
  final ProductVariation? selectedVariation;
  @override
  Widget builder(
    BuildContext context,
    VariableProductSheetModel viewModel,
    Widget? child,
  ) {
    List<String> images = product.images;
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          constraints: BoxConstraints(maxHeight: screenHeight(context) * .8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageSection(images, width: screenWidth(context) * .5),
                    viewModel.isBusy
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : ListView(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              verticalSpaceSmall,
                              if (viewModel.attributes.isNotEmpty)
                                AttributesSection(
                                  attributes: viewModel.attributes,
                                  combinations: viewModel.combinations,
                                  selectVariation: (value) {
                                    if (value != null) {
                                      if (value.image != null) {
                                        if (!images.contains(value.image)) {
                                          images.add(value.image!);
                                        }
                                      }
                                      viewModel.selectVariation(value);
                                    }
                                  },
                                  selectedVariation: selectedVariation,
                                ),
                            ],
                          )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: kcSecondaryColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveText(
                            "total_price",
                            style: Theme.of(context).textTheme.titleSmall!,
                          ),
                          ResponsiveText(
                            viewModel.selectedVariation?.price ?? "N/A",
                            style: Theme.of(context).textTheme.headlineSmall!,
                          )
                        ],
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: BaseButton(
                          title: "confirm",
                          callback: () {
                            Navigator.pop(context, viewModel.selectedVariation);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  VariableProductSheetModel viewModelBuilder(
    BuildContext context,
  ) =>
      VariableProductSheetModel(product);
}
