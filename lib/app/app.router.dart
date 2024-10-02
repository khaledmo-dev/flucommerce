// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flucommerce/data/models/category.dart' as _i23;
import 'package:flucommerce/data/models/product.dart' as _i22;
import 'package:flucommerce/data/repositories/product_repository.dart' as _i21;
import 'package:flucommerce/services/hive_db.dart' as _i20;
import 'package:flucommerce/ui/views/cart/cart_view.dart' as _i9;
import 'package:flucommerce/ui/views/categories/categories_view.dart' as _i16;
import 'package:flucommerce/ui/views/category_details/category_details_view.dart'
    as _i17;
import 'package:flucommerce/ui/views/checkout/checkout_view.dart' as _i6;
import 'package:flucommerce/ui/views/favorites/favorites_view.dart' as _i10;
import 'package:flucommerce/ui/views/home/home_view.dart' as _i2;
import 'package:flucommerce/ui/views/login/login_view.dart' as _i11;
import 'package:flucommerce/ui/views/main/main_view.dart' as _i4;
import 'package:flucommerce/ui/views/orders/orders_view.dart' as _i8;
import 'package:flucommerce/ui/views/product_details/product_details_view.dart'
    as _i15;
import 'package:flucommerce/ui/views/products/products_view.dart' as _i14;
import 'package:flucommerce/ui/views/profile/profile_view.dart' as _i18;
import 'package:flucommerce/ui/views/register/register_view.dart' as _i12;
import 'package:flucommerce/ui/views/reviews/reviews_view.dart' as _i7;
import 'package:flucommerce/ui/views/search/search_view.dart' as _i13;
import 'package:flucommerce/ui/views/settings/settings_view.dart' as _i5;
import 'package:flucommerce/ui/views/startup/startup_view.dart' as _i3;
import 'package:flutter/material.dart' as _i19;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i24;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const mainView = '/main-view';

  static const settingsView = '/settings-view';

  static const checkoutView = '/checkout-view';

  static const reviewsView = '/reviews-view';

  static const ordersView = '/orders-view';

  static const cartView = '/cart-view';

  static const favoritesView = '/favorites-view';

  static const loginView = '/login-view';

  static const registerView = '/register-view';

  static const searchView = '/search-view';

  static const productsView = '/products-view';

  static const productDetailsView = '/product-details-view';

  static const categoriesView = '/categories-view';

  static const categoryDetailsView = '/category-details-view';

  static const profileView = '/profile-view';

  static const all = <String>{
    homeView,
    startupView,
    mainView,
    settingsView,
    checkoutView,
    reviewsView,
    ordersView,
    cartView,
    favoritesView,
    loginView,
    registerView,
    searchView,
    productsView,
    productDetailsView,
    categoriesView,
    categoryDetailsView,
    profileView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i4.MainView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i5.SettingsView,
    ),
    _i1.RouteDef(
      Routes.checkoutView,
      page: _i6.CheckoutView,
    ),
    _i1.RouteDef(
      Routes.reviewsView,
      page: _i7.ReviewsView,
    ),
    _i1.RouteDef(
      Routes.ordersView,
      page: _i8.OrdersView,
    ),
    _i1.RouteDef(
      Routes.cartView,
      page: _i9.CartView,
    ),
    _i1.RouteDef(
      Routes.favoritesView,
      page: _i10.FavoritesView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i11.LoginView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i12.RegisterView,
    ),
    _i1.RouteDef(
      Routes.searchView,
      page: _i13.SearchView,
    ),
    _i1.RouteDef(
      Routes.productsView,
      page: _i14.ProductsView,
    ),
    _i1.RouteDef(
      Routes.productDetailsView,
      page: _i15.ProductDetailsView,
    ),
    _i1.RouteDef(
      Routes.categoriesView,
      page: _i16.CategoriesView,
    ),
    _i1.RouteDef(
      Routes.categoryDetailsView,
      page: _i17.CategoryDetailsView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i18.ProfileView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.MainView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.MainView(),
        settings: data,
      );
    },
    _i5.SettingsView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SettingsView(),
        settings: data,
      );
    },
    _i6.CheckoutView: (data) {
      final args = data.getArgs<CheckoutViewArguments>(nullOk: false);
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.CheckoutView(args.items, key: args.key),
        settings: data,
      );
    },
    _i7.ReviewsView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.ReviewsView(),
        settings: data,
      );
    },
    _i8.OrdersView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.OrdersView(),
        settings: data,
      );
    },
    _i9.CartView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.CartView(),
        settings: data,
      );
    },
    _i10.FavoritesView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.FavoritesView(),
        settings: data,
      );
    },
    _i11.LoginView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.LoginView(),
        settings: data,
      );
    },
    _i12.RegisterView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.RegisterView(),
        settings: data,
      );
    },
    _i13.SearchView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.SearchView(),
        settings: data,
      );
    },
    _i14.ProductsView: (data) {
      final args = data.getArgs<ProductsViewArguments>(nullOk: false);
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i14.ProductsView(args.productParameters, key: args.key),
        settings: data,
      );
    },
    _i15.ProductDetailsView: (data) {
      final args = data.getArgs<ProductDetailsViewArguments>(nullOk: false);
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i15.ProductDetailsView(args.product, key: args.key),
        settings: data,
      );
    },
    _i16.CategoriesView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.CategoriesView(),
        settings: data,
      );
    },
    _i17.CategoryDetailsView: (data) {
      final args = data.getArgs<CategoryDetailsViewArguments>(nullOk: false);
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.CategoryDetailsView(args.category, key: args.key),
        settings: data,
      );
    },
    _i18.ProfileView: (data) {
      return _i19.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.ProfileView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class CheckoutViewArguments {
  const CheckoutViewArguments({
    required this.items,
    this.key,
  });

  final List<_i20.CartItem> items;

  final _i19.Key? key;

  @override
  String toString() {
    return '{"items": "$items", "key": "$key"}';
  }

  @override
  bool operator ==(covariant CheckoutViewArguments other) {
    if (identical(this, other)) return true;
    return other.items == items && other.key == key;
  }

  @override
  int get hashCode {
    return items.hashCode ^ key.hashCode;
  }
}

class ProductsViewArguments {
  const ProductsViewArguments({
    required this.productParameters,
    this.key,
  });

  final _i21.ProductQueryParams productParameters;

  final _i19.Key? key;

  @override
  String toString() {
    return '{"productParameters": "$productParameters", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ProductsViewArguments other) {
    if (identical(this, other)) return true;
    return other.productParameters == productParameters && other.key == key;
  }

  @override
  int get hashCode {
    return productParameters.hashCode ^ key.hashCode;
  }
}

class ProductDetailsViewArguments {
  const ProductDetailsViewArguments({
    required this.product,
    this.key,
  });

  final _i22.Product product;

  final _i19.Key? key;

  @override
  String toString() {
    return '{"product": "$product", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ProductDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.product == product && other.key == key;
  }

  @override
  int get hashCode {
    return product.hashCode ^ key.hashCode;
  }
}

class CategoryDetailsViewArguments {
  const CategoryDetailsViewArguments({
    required this.category,
    this.key,
  });

  final _i23.Category category;

  final _i19.Key? key;

  @override
  String toString() {
    return '{"category": "$category", "key": "$key"}';
  }

  @override
  bool operator ==(covariant CategoryDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.category == category && other.key == key;
  }

  @override
  int get hashCode {
    return category.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i24.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCheckoutView({
    required List<_i20.CartItem> items,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.checkoutView,
        arguments: CheckoutViewArguments(items: items, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReviewsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.reviewsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrdersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ordersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCartView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.cartView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFavoritesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.favoritesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductsView({
    required _i21.ProductQueryParams productParameters,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productsView,
        arguments: ProductsViewArguments(
            productParameters: productParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductDetailsView({
    required _i22.Product product,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(product: product, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCategoriesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.categoriesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCategoryDetailsView({
    required _i23.Category category,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.categoryDetailsView,
        arguments: CategoryDetailsViewArguments(category: category, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCheckoutView({
    required List<_i20.CartItem> items,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.checkoutView,
        arguments: CheckoutViewArguments(items: items, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithReviewsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.reviewsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrdersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ordersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCartView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.cartView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFavoritesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.favoritesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductsView({
    required _i21.ProductQueryParams productParameters,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productsView,
        arguments: ProductsViewArguments(
            productParameters: productParameters, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductDetailsView({
    required _i22.Product product,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productDetailsView,
        arguments: ProductDetailsViewArguments(product: product, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCategoriesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.categoriesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCategoryDetailsView({
    required _i23.Category category,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.categoryDetailsView,
        arguments: CategoryDetailsViewArguments(category: category, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
