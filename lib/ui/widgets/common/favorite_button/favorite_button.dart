import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

import 'favorite_button_model.dart';

class FavoriteButton extends StackedView<FavoriteButtonModel> {
  const FavoriteButton(this.product, {super.key});
  final Product product;

  @override
  Widget builder(
    BuildContext context,
    FavoriteButtonModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        viewModel.toggleFavoriteStatus();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        // visualDensity: VisualDensity.compact,
        child: ResponsiveIcon(
          viewModel.isFavorited ? IconlyBold.heart : IconlyLight.heart,
          color: viewModel.isFavorited ? Colors.red : null,
        ),
      ),
    );
  }

  @override
  FavoriteButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      FavoriteButtonModel(product);
}
