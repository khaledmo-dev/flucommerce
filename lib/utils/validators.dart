import 'package:flucommerce/services/translation_service.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "required_field".translate();
  } else if (RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      ).hasMatch(value) ==
      false) {
    return "email_not_valid".translate();
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "required_field".translate();
  } else if (RegExp(r'^.{6,}$').hasMatch(value) == false) {
    return "short_password".translate();
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return "required_field".translate();
  }
  return null;
}

int calculateSalePercentage(String sale, String regular) {
  int? salePrice = int.tryParse(sale);
  int? regularPrice = int.tryParse(regular);

  if (salePrice == null || regularPrice == null) {
    return 0;
  }
  var percentage = ((regularPrice - salePrice) / regularPrice) * 100;
  return percentage.toInt();
}
