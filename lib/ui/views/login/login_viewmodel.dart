import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authRepository = locator<AuthRepository>();

  navigateToRegister() {
    _navigationService.replaceWithRegisterView();
  }

  enterAsGuest() {
    _navigationService.replaceWithMainView();
  }

  login() async {
    if (isFormValid) {
      setBusy(true);
      var reponse = await _authRepository.signInWithEmailAndPassword(
        userName: emailValue!,
        password: passwordValue!,
      );
      reponse.fold(
        (l) {},
        (r) {
          _navigationService.replaceWithMainView();
        },
      );
      setBusy(false);
    }
  }
}
