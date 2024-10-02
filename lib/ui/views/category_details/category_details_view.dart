import 'package:cached_network_image/cached_network_image.dart';
import 'package:flucommerce/data/models/category.dart';
import 'package:flucommerce/ui/common/common.dart';
import 'package:flucommerce/ui/widgets/common/product_grid/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'category_details_viewmodel.dart';

class CategoryDetailsView extends StackedView<CategoryDetailsViewModel> {
  const CategoryDetailsView(this.category, {Key? key}) : super(key: key);
  final Category category;
  @override
  Widget builder(
    BuildContext context,
    CategoryDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Builder(
        builder: (context) {
          if (viewModel.isBusy) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: kcPrimaryColor,
                size: 40,
              ),
            );
          }
          return ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            children: [
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: viewModel.subCategories
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    width: screenWidth(context) / 5,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kcSecondaryColor,
                                        ),
                                        child: category.image != null
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: category.image!,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const SizedBox(),
                                                ),
                                              )
                                            : const ResponsiveIcon(
                                                Icons.image,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                ResponsiveText(
                                  e.name,
                                  style: Theme.of(context).textTheme.bodySmall!,
                                  alignment: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              verticalSpaceSmall,
              ProductGrid(
                viewModel.products,
                isPaginating: viewModel.busy("paginate"),
                fetchMore: viewModel.hasMore ? viewModel.fetchProducts : null,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  CategoryDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryDetailsViewModel(category);
}
