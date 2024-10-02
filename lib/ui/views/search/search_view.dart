import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/views/search/search_view.form.dart';
import 'package:flucommerce/ui/widgets/common/filter_search_sheet/filter_search_sheet.dart';
import 'package:flucommerce/ui/widgets/common/paginated_products_list/paginated_products_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flucommerce/ui/common/common.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'search_viewmodel.dart';

@FormView(
  fields: [FormTextField(name: 'search')],
)
class SearchView extends StackedView<SearchViewModel> with $SearchView {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          "search".translate(),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
          child: TextField(
            controller: searchController,
            onSubmitted: (value) => viewModel.fetchProducts(),
            cursorColor: kcPrimaryColor,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize! *
                    (screenWidth(context) / 3.5) /
                    100),
            decoration: InputDecoration(
              prefixIcon: ResponsiveIcon(
                IconlyLight.search,
                color: kcPrimaryColor,
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  var passedParameters = await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    backgroundColor: kcButtonIconColor,
                    builder: (_) {
                      return FilterSearchSheet(viewModel.parameters);
                    },
                  );
                  if (passedParameters != null) {
                    if (passedParameters == "clear") {
                      viewModel.clearParameters();
                    } else {
                      viewModel.applyParameters(passedParameters);
                    }
                  }
                },
                icon: Builder(
                  builder: (context) {
                    return ResponsiveIcon(
                      viewModel.isFilterEnabled
                          ? IconlyBold.filter
                          : IconlyLight.filter,
                      color: kcPrimaryColor,
                    );
                  },
                ),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              isDense: true,
              hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize! *
                      (screenWidth(context) / 3.5) /
                      100),
              filled: true,
              fillColor: kcSecondaryColor,
              hintText: '${"search"}..',
            ),
          ),
        ),
        verticalSpaceSmall,
        Builder(
          builder: (context) {
            if (viewModel.isBusy) {
              return Expanded(
                child: Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: kcPrimaryColor,
                    size: 40,
                  ),
                ),
              );
            }
            if (viewModel.products.isNotEmpty) {
              return Expanded(
                child: PaginatedProductsList(
                  products: viewModel.products,
                  paginate: () {
                    viewModel.fetchProducts();
                  },
                  isLoading: viewModel.busy("paginate"),
                ),
              );
            }

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/$notFoundImage.png'),
                  verticalSpaceMedium,
                  ResponsiveText(
                    "no_results".translate(),
                    alignment: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
            );

            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context) * .3,
                    child: const FittedBox(
                      fit: BoxFit.fitWidth,
                      child: ResponsiveIcon(
                        IconlyBold.search,
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  ResponsiveText(
                    "search".translate(),
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ],
              ),
            );
          },
        )
      ]),
    );
  }

  @override
  void onViewModelReady(SearchViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(SearchViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
}
