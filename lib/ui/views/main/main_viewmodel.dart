import 'package:flucommerce/ui/views/cart/cart_view.dart';
import 'package:flucommerce/ui/views/categories/categories_view.dart';
import 'package:flucommerce/ui/views/home/home_view.dart';
import 'package:flucommerce/ui/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends IndexTrackingViewModel {
  List<Widget> pages = const [
    HomeView(),
    CategoriesView(),
    CartView(),
    SettingsView(),
  ];

  Widget get currentView => pages[currentIndex];
}
