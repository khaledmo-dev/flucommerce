import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/views/home/widgets/home_view_loading.dart';
import 'package:flucommerce/ui/views/home/widgets/products_horizontal_list.dart';
import 'package:flucommerce/ui/widgets/common/category_grid/category_grid.dart';
import 'package:flucommerce/ui/widgets/common/product_grid/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  bool get initialiseSpecialViewModelsOnce => true;

  @override
  bool get disposeViewModel => false;
  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(
                  'assets/icon.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            horizontalSpaceTiny,
            ResponsiveText(
              'فلوكوميرس',
              style: Theme.of(context).textTheme.bodySmall!,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (viewModel.hasError) {
            return Center(child: Text(viewModel.modelError.toString()));
          }
          if (viewModel.isBusy) {
            return const HomeViewLoading();
          }
          return SingleChildScrollView(
            // controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  TextField(
                    cursorColor: kcPrimaryColor,
                    readOnly: true,
                    onTap: () {
                      viewModel.navigateToSearch();
                      // Navigator.of(context).push(_createRoute());
                    },
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize! *
                                (screenWidth(context) / 3.5) /
                                100),
                    decoration: InputDecoration(
                      prefixIcon: ResponsiveIcon(
                        IconlyLight.search,
                        color: kcPrimaryColor,
                      ),
                      suffixIcon: ResponsiveIcon(
                        IconlyLight.filter,
                        color: kcPrimaryColor,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      isDense: true,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize! *
                                  (screenWidth(context) / 3.5) /
                                  100),
                      filled: true,
                      fillColor: kcSecondaryColor,
                      // hintText: '${localization.search}..',
                    ),
                  ),
                  verticalSpaceMedium,
                  CategoryGrid(viewModel.categories),
                  verticalSpaceSmall,
                  if ((viewModel.productSections["featured"]?.length ?? 0) > 0)
                    ProductsHorizontalList(
                      viewModel.productSections["featured"]!,
                      title: "featured_products".translate(),
                    ),
                  if ((viewModel.productSections["on-sale"]?.length ?? 0) > 0)
                    ProductsHorizontalList(
                      viewModel.productSections["on-sale"]!,
                      title: "on_sale_products".translate(),
                    ),
                  verticalSpaceSmall,
                  if ((viewModel.productSections["latest"]?.length ?? 0) > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ResponsiveText(
                              "latest_products".translate(),
                              style: Theme.of(context).textTheme.headlineSmall!,
                            ),
                            GestureDetector(
                              onTap: () {
                                locator<NavigationService>()
                                    .navigateToProductsView(
                                        productParameters:
                                            ProductQueryParams());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 12.0,
                                ),
                                decoration: BoxDecoration(
                                  color: kcSecondaryColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  "view_all".translate(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                        verticalSpaceSmall,
                        ProductGrid(viewModel.productSections["latest"] ?? []),
                      ],
                    ),
                  verticalSpaceSmall,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      locator<HomeViewModel>();
}
