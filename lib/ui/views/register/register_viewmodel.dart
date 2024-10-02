import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'register_view.form.dart';

class RegisterViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();

  navigateToLogin() {
    _navigationService.replaceWithLoginView();
  }

  enterAsGuest() {
    _navigationService.replaceWithMainView();
  }

  register() async {
    if (isFormValid) {
      setBusy(true);
      var reponse = await _authRepository.register(
        emailAddress: emailValue!,
        password: passwordValue!,
        userName: usernameValue!,
      );
      reponse.fold(
        (l) {},
        (r) {
          _navigationService.replaceWithHomeView();
        },
      );
      setBusy(false);
    }
  }
}
