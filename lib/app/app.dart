import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:flucommerce/data/repositories/cart_repository.dart';
import 'package:flucommerce/data/repositories/category_repository.dart';
import 'package:flucommerce/data/repositories/favorite_repository.dart';
import 'package:flucommerce/data/repositories/order_repository.dart';
import 'package:flucommerce/data/repositories/product_repository.dart';
import 'package:flucommerce/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:flucommerce/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:flucommerce/ui/views/cart/cart_viewmodel.dart';
import 'package:flucommerce/ui/views/home/home_view.dart';
import 'package:flucommerce/ui/views/home/home_viewmodel.dart';
import 'package:flucommerce/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flucommerce/ui/views/main/main_view.dart';
import 'package:flucommerce/ui/views/settings/settings_view.dart';
import 'package:flucommerce/ui/views/checkout/checkout_view.dart';
import 'package:flucommerce/ui/views/reviews/reviews_view.dart';
import 'package:flucommerce/ui/views/orders/orders_view.dart';
import 'package:flucommerce/ui/views/cart/cart_view.dart';
import 'package:flucommerce/ui/views/favorites/favorites_view.dart';
import 'package:flucommerce/services/client_service.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:flucommerce/ui/views/login/login_view.dart';
import 'package:flucommerce/ui/views/register/register_view.dart';
import 'package:flucommerce/services/theme_service.dart';
import 'package:flucommerce/ui/views/search/search_view.dart';
import 'package:flucommerce/ui/views/products/products_view.dart';
import 'package:flucommerce/ui/views/product_details/product_details_view.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/services/flash_message_service.dart';
import 'package:flucommerce/ui/views/categories/categories_view.dart';
import 'package:flucommerce/ui/views/category_details/category_details_view.dart';
import 'package:flucommerce/ui/views/profile/profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: CheckoutView),
    MaterialRoute(page: ReviewsView),
    MaterialRoute(page: OrdersView),
    MaterialRoute(page: CartView),
    MaterialRoute(page: FavoritesView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: ProductsView),
    MaterialRoute(page: ProductDetailsView),
    MaterialRoute(page: CategoriesView),
    MaterialRoute(page: CategoryDetailsView),
    MaterialRoute(page: ProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ClientService),
    InitializableSingleton(classType: LocalStorageService),

    LazySingleton(classType: AuthRepositoryImpl, asType: AuthRepository),
    LazySingleton(classType: ProductRepositoryImpl, asType: ProductRepository),
    LazySingleton(
        classType: CategoryRepositoryImpl, asType: CategoryRepository),
    InitializableSingleton(
        classType: OrderRepositoryImpl, asType: OrderRepository),

    InitializableSingleton(
        classType: CartRepositoryImpl, asType: CartRepository),
    InitializableSingleton(
        classType: FavoriteRepositoryImpl, asType: FavoriteRepository),
    LazySingleton(classType: ThemeService),

    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: CartViewModel),

    LazySingleton(classType: TranslationService),
    LazySingleton(classType: FlashMessageService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
