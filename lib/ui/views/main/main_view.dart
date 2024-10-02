import 'package:flucommerce/ui/common/base_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

class MainView extends StackedView<MainViewModel> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MainViewModel viewModel,
    Widget? child,
  ) {
    List views = [
      {
        'index': 0,
        'title': "home",
        'icon-bold': IconlyBold.home,
        'icon-light': IconlyLight.home
      },
      {
        'index': 1,
        'title': "categories",
        'icon-bold': IconlyBold.category,
        'icon-light': IconlyLight.category,
      },
      {
        'index': 2,
        'title': "cart",
        'icon-bold': IconlyBold.bag,
        'icon-light': IconlyLight.bag
      },
      {
        'index': 3,
        'title': "settings",
        'icon-bold': IconlyBold.setting,
        'icon-light': IconlyLight.setting
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BaseBottomBar(
        views: views,
        currentIndex: viewModel.currentIndex,
        setIndex: viewModel.setIndex,
      ),
      body: viewModel.currentView,
    );
  }

  @override
  MainViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MainViewModel();
}
