// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../data/repositories/auth_repository.dart';
import '../data/repositories/cart_repository.dart';
import '../data/repositories/category_repository.dart';
import '../data/repositories/favorite_repository.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/product_repository.dart';
import '../services/client_service.dart';
import '../services/flash_message_service.dart';
import '../services/local_storage_service.dart';
import '../services/theme_service.dart';
import '../services/translation_service.dart';
import '../ui/views/cart/cart_viewmodel.dart';
import '../ui/views/home/home_viewmodel.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ClientService());
  final localStorageService = LocalStorageService();
  await localStorageService.init();
  locator.registerSingleton(localStorageService);

  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  locator
      .registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  locator.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl());
  final orderRepositoryImpl = OrderRepositoryImpl();
  await orderRepositoryImpl.init();
  locator.registerSingleton<OrderRepository>(orderRepositoryImpl);

  final cartRepositoryImpl = CartRepositoryImpl();
  await cartRepositoryImpl.init();
  locator.registerSingleton<CartRepository>(cartRepositoryImpl);

  final favoriteRepositoryImpl = FavoriteRepositoryImpl();
  await favoriteRepositoryImpl.init();
  locator.registerSingleton<FavoriteRepository>(favoriteRepositoryImpl);

  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => CartViewModel());
  locator.registerLazySingleton(() => TranslationService());
  locator.registerLazySingleton(() => FlashMessageService());
}
