import 'package:flucommerce/services/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/category_grid/category_grid.dart';
import 'categories_viewmodel.dart';

class CategoriesView extends StackedView<CategoriesViewModel> {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CategoriesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text("categories".translate())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: CategoryGrid(
          viewModel.data ?? [],
          columnCount: 3,
          limitRows: false,
        ),
      ),
    );
  }

  @override
  CategoriesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoriesViewModel();
}
