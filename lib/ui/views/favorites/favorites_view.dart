import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

import 'favorites_viewmodel.dart';

class FavoritesView extends StackedView<FavoritesViewModel> {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FavoritesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          "wish_slist",
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: viewModel.favoriteListenable,
            builder: (context, box, _) {
              var products = box.values.toList();
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: ((context, index) {
                  var product = products[index];
                  return GestureDetector(
                    onTap: () {
                      viewModel.navigateToProductDetails(product.productID);
                    },
                    child: FavoriteListTile(
                      product: product,
                      removeFavorite: () {
                        viewModel.removeFavorite(product);
                      },
                    ),
                  );
                }),
              );
            },
          ),
          if (viewModel.isBusy)
            Container(
              width: screenWidth(context),
              height: screenHeight(context),
              color: Colors.black38,
              child: Center(
                child: CircularProgressIndicator(color: kcPrimaryColor),
              ),
            )
        ],
      ),
    );
  }

  @override
  FavoritesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FavoritesViewModel();
}

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({
    super.key,
    required this.product,
    required this.removeFavorite,
  });

  final Favorite product;
  final Function removeFavorite;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        return Container(
          margin: const EdgeInsets.only(bottom: 12, right: 24, left: 24),
          decoration: BoxDecoration(
            color: kcCartItemBackgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 12.0, 0, 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: width * .2,
                          height: width * .2,
                          constraints: const BoxConstraints(
                              maxHeight: 200, maxWidth: 200),
                          color: kcSecondaryColor,
                          child: product.image != null
                              ? Image.network(product.image!)
                              : const ResponsiveIcon(Icons.image),
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: ResponsiveText(
                        product.productName,
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                splashRadius: 1,
                onPressed: () {
                  removeFavorite();
                },
                icon: const ResponsiveIcon(
                  IconlyLight.delete,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
