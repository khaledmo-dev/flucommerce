import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/base_text_field.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/login/login_view.form.dart';
import 'package:flucommerce/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'email', validator: validateUsername),
    FormTextField(name: 'password', validator: validatePassword),
  ],
  autoTextFieldValidation: false,
)
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: SizedBox(
          height: screenHeight(context),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ResponsiveText(
                "login".translate(),
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
              verticalSpaceMassive,
              Column(
                children: [
                  SizedBox(height: screenHeight(context) * .02),
                  BaseTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: "email".translate(),
                    icon: IconlyBold.message,
                    errorText: viewModel.emailValidationMessage,
                  ),
                  SizedBox(height: screenHeight(context) * .02),
                  BaseTextField(
                    controller: passwordController,
                    hint: "password".translate(),
                    icon: IconlyBold.lock,
                    isPassword: true,
                    errorText: viewModel.passwordValidationMessage,
                  ),
                  SizedBox(height: screenHeight(context) * .04),
                ],
              ),
              verticalSpaceMedium,
              Column(
                children: [
                  BaseButton(
                    icon: Icons.arrow_forward_sharp,
                    title: "login".translate(),
                    callback: () {
                      viewModel.login();
                    },
                    isLoading: viewModel.isBusy,
                  ),
                  SizedBox(height: screenHeight(context) * .03),
                  GestureDetector(
                    onTap: () {
                      viewModel.navigateToRegister();
                    },
                    child: ResponsiveText(
                      "or_register".translate(),
                      style: const TextStyle(
                        color: kcMediumGreyColorLightTheme,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  GestureDetector(
                    onTap: () {
                      viewModel.enterAsGuest();
                    },
                    child: const ResponsiveText(
                      'الدخول كزائر',
                      style: TextStyle(
                        color: kcMediumGreyColorLightTheme,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(LoginViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
