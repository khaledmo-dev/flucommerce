import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flucommerce/data/models/category.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:collection/collection.dart';
import 'category_grid_model.dart';

class CategoryGrid extends StackedView<CategoryGridModel> {
  const CategoryGrid(
    this.categories, {
    super.key,
    this.columnCount = 4,
    this.limitRows = true,
  });
  final List<Category> categories;
  final int columnCount;
  final bool limitRows;

  @override
  Widget builder(
    BuildContext context,
    CategoryGridModel viewModel,
    Widget? child,
  ) {
    int rowsCount = 2;
    late int actualRowsCount;
    if (limitRows) {
      actualRowsCount =
          min((categories.length / columnCount).ceil(), rowsCount);
    } else {
      actualRowsCount = (categories.length / columnCount).ceil();
    }

    bool moreAvailable = categories.length > (columnCount * rowsCount);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (var i = 0; i < actualRowsCount; i++)
          LayoutBuilder(
            builder: (context, constraints) {
              bool isLastRow = i == actualRowsCount - 1;
              List<Category> rowCategories =
                  categories.skip(i * columnCount).take(columnCount).toList();
              return Padding(
                padding: EdgeInsets.only(bottom: isLastRow ? 0 : 12.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: rowCategories.mapIndexed(
                      (index, category) {
                        bool isLast = columnCount - 1 == index;
                        if (isLast && moreAvailable && isLastRow) {
                          return SizedBox(
                            width: (constraints.maxWidth / columnCount) -
                                (12 * .75),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kcSecondaryColor,
                                      ),
                                      child: const ResponsiveIcon(Icons.add),
                                    ),
                                  ),
                                  verticalSpaceTiny,
                                  ResponsiveText(
                                    "${categories.length - (columnCount * rowsCount) + 1} More",
                                    style:
                                        Theme.of(context).textTheme.bodySmall!,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Container(
                          width:
                              (constraints.maxWidth / columnCount) - (12 * .75),
                          margin: EdgeInsetsDirectional.only(
                            end: isLast ? 0 : 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              viewModel.navigateToCategoryProducts(category);
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
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
                                  verticalSpaceTiny,
                                  ResponsiveText(
                                    category.name,
                                    style:
                                        Theme.of(context).textTheme.bodySmall!,
                                    alignment: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            },
          )
      ],
    );
  }

  @override
  CategoryGridModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryGridModel();
}
