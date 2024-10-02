import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:flucommerce/ui/widgets/common/paginated_products_list/paginated_products_list.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:flucommerce/ui/common/common.dart';

import 'products_viewmodel.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView(this.productParameters, {Key? key}) : super(key: key);
  final ProductQueryParams productParameters;
  @override
  Widget builder(
    BuildContext context,
    ProductsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products List")),
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
          return PaginatedProductsList(
            products: viewModel.products,
            paginate: viewModel.fetchProducts,
            isLoading: viewModel.busy("paginate"),
          );
        },
      ),
    );
  }

  @override
  ProductsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductsViewModel(productParameters);
}
