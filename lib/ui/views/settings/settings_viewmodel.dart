import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:flucommerce/main.dart';
import 'package:flucommerce/services/flash_message_service.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/views/settings/screens/contact_screen.dart';
import 'package:flucommerce/ui/views/settings/screens/refund_policy_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();
  final _flashMessageService = locator<FlashMessageService>();
  final _localStorage = locator<LocalStorageService>();

  bool get isGuest => _authRepository.isGuest();

  toggleTheme() {
    bool isDark = _localStorage.isDarkMode;
    _localStorage.isDarkMode = !isDark;
    themeNotifier.value = !isDark;
  }

  navigateToLogin() {
    _navigationService.replaceWithLoginView();
  }

  navigateToProfile() {
    if (_authRepository.isGuest()) {
      _flashMessageService.showMessage(
        title: "login_first".translate(),
        message: " ",
        type: FlashMessageType.warning,
      );
    } else {
      _navigationService.navigateToProfileView();
    }
  }

  navigateToOrders() {
    _navigationService.navigateToOrdersView();
  }

  navigateToFavorites() {
    _navigationService.navigateToFavoritesView();
  }

  navigateToContactScreen() {
    _navigationService.navigateToView(const ContactUsScreen());
  }

  navigateToRefundScreen() {
    _navigationService.navigateToView(const RefundPolicyScreen());
  }

  logout() {
    _authRepository.logout();
    _navigationService.replaceWithLoginView();
  }
}
