import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.logger.dart';
import 'package:flucommerce/data/repositories/auth_repository.dart';
import 'package:flucommerce/services/flash_message_service.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'profile_view.form.dart';

class ProfileViewModel extends FutureViewModel
    with FormStateHelper
    implements FormViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _flashMessageService = locator<FlashMessageService>();
  final logger = getLogger("ProfileViewModel");

  editProfile() async {
    var user = _authRepository.getSignedInUser()!;
    var contactDetails = user.shipping!.copyWith(
      firstName: firstNameValue,
      lastName: lastNameValue,
      address1: addressValue,
      phone: phoneValue,
      email: user.email,
    );

    setBusy(true);
    var response = await _authRepository.setupAccount(
      user: user.copyWith(
        firstName: firstNameValue,
        lastName: lastNameValue,
        shipping: contactDetails,
        billing: contactDetails,
      ),
    );
    response.fold(
      (l) {
        logger.wtf(l);

        _flashMessageService.showMessage(
            title: "error".translate(),
            message: "something_went_wrong_try_again".translate(),
            type: FlashMessageType.danger);
      },
      (r) {
        _navigationService.back();
      },
    );
    setBusy(false);
  }

  @override
  Future futureToRun() async {
    var response = await _authRepository.getUserDetails();

    return response.fold(
      (l) {
        throw l;
      },
      (r) {
        firstNameValue = r.shipping?.firstName;
        lastNameValue = r.shipping?.lastName;
        addressValue = r.shipping?.address1;
        phoneValue = r.shipping?.phone;

        return r;
      },
    );
  }
}
