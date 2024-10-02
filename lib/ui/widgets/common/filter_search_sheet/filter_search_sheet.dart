import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

import 'filter_search_sheet_model.dart';

class FilterSearchSheet extends StackedView<FilterSearchSheetModel> {
  const FilterSearchSheet(this.parameters, {super.key});
  final ProductQueryParams parameters;
  @override
  Widget builder(
    BuildContext context,
    FilterSearchSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            var height = constraints.maxHeight;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop("clear");
                      },
                      child: ResponsiveText(
                        "clear".translate(),
                        style: Theme.of(context).textTheme.bodySmall!,
                      ),
                    ),
                    ResponsiveText(
                      "filters".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const ResponsiveIcon(IconlyBold.close_square),
                    )
                  ],
                ),
                const Divider(),
                verticalSpaceSmall,
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     ResponsiveText(
                //       "category",
                //       style: const TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     verticalSpaceTiny,
                //     SizedBox(height: height * .1, child: CategoriesList())
                //   ],
                // ),
                verticalSpaceSmall,
                const OrderbyOptionsList(),

                verticalSpaceSmall,
                PricingSection(height: height),
                verticalSpaceSmall,
                BaseButton(
                  title: "apply_filters".translate(),
                  callback: () {
                    Navigator.of(context).pop(viewModel.parameters);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void onViewModelReady(FilterSearchSheetModel viewModel) {
    viewModel.syncParameters(parameters);
    super.onViewModelReady(viewModel);
  }

  @override
  FilterSearchSheetModel viewModelBuilder(
    BuildContext context,
  ) =>
      FilterSearchSheetModel();
}

class PricingSection extends StatelessWidget {
  const PricingSection({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    var model = getParentViewModel<FilterSearchSheetModel>(context);
    var parameters = model.parameters;

    RangeValues currentRangeValues = RangeValues(
      double.tryParse(parameters.minPrice ?? '') ?? 0,
      double.tryParse(parameters.maxPrice ?? '') ?? 500,
    );

    var firstRangePoint = currentRangeValues.start.round().toString();
    var secondRangePoint = currentRangeValues.end.round().toString();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ResponsiveText("pricing".translate(),
                style: Theme.of(context).textTheme.headlineSmall!),
            ResponsiveText('\$$firstRangePoint-\$$secondRangePoint',
                style: Theme.of(context).textTheme.headlineSmall!),
          ],
        ),
        verticalSpaceMedium,
        RangeSlider(
          values: currentRangeValues,
          activeColor: kcPrimaryColor,
          max: 500,
          divisions: 50,
          labels: RangeLabels(
            currentRangeValues.start.round().toString(),
            currentRangeValues.end.round().toString(),
          ),
          onChanged: (value) {
            model.updatePriceRange(minPrice: value.start, maxPrice: value.end);
          },
        )
      ],
    );
  }
}

// class CategoriesList extends StatelessWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   CategoriesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // var state = BlocProvider.of<SearchBloc>(context).state;
//     String selectedCategory = state.searchParmas.categoryID ?? '';
//     var categories = BlocProvider.of<HomeBloc>(context).state.categories;
//     return ListView.builder(
//       itemCount: categories.length,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         var category = categories[index];
//         bool isSelected =
//             selectedCategory == category.id.toString() ? true : false;
//         return category.name != 'Uncategorized'
//             ? GestureDetector(
//                 onTap: () {
//                   // BlocProvider.of<SearchBloc>(context).add(SetFilters(
//                   //   state.searchParmas
//                   //       .copyWith(categoryID: category.id.toString()),
//                   // ));
//                 },
//                 child: Container(
//                   margin: const EdgeInsetsDirectional.only(end: 10),
//                   decoration: BoxDecoration(
//                     color: isSelected ? kcPrimaryColor : Colors.transparent,
//                     borderRadius: BorderRadius.circular(100),
//                     border: Border.all(
//                       color: isSelected ? kcPrimaryColor : kcSecondaryColor,
//                       width: 2,
//                     ),
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0, vertical: 6),
//                       child: ResponsiveText(
//                         category.name,
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleMedium!
//                             .copyWith(
//                               color: isSelected ? kcButtonIconColor : null,
//                               fontWeight: isSelected ? FontWeight.bold : null,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : const SizedBox();
//       },
//     );
//   }
// }

class OrderbyOptionsList extends StatelessWidget {
  const OrderbyOptionsList({super.key});
  @override
  Widget build(BuildContext context) {
    var model = getParentViewModel<FilterSearchSheetModel>(context);
    var parameters = model.parameters;

    Map orderbyOptions = {
      "popularity": "Popular",
      "date": "Most Recent",
      "rating": "Rating"
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          "sort_by".translate(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceSmall,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: orderbyOptions.entries.map((e) {
              bool isSelected = parameters.orderBy == e.key;
              return GestureDetector(
                onTap: () {
                  model.updateOrderby(e.key);
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected ? kcPrimaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: isSelected ? kcPrimaryColor : kcSecondaryColor,
                        width: 2),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 6),
                      child: ResponsiveText(
                        e.value,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: isSelected ? kcButtonIconColor : null,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
