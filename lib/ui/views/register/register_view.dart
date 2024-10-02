import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/base_text_field.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/register/register_view.form.dart';
import 'package:flucommerce/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'register_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'email', validator: validateEmail),
    FormTextField(name: 'password', validator: validatePassword),
    FormTextField(name: 'username', validator: validateUsername),
  ],
  autoTextFieldValidation: false,
)
class RegisterView extends StackedView<RegisterViewModel> with $RegisterView {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 0),
          // reverse: true,
          child: Column(
            children: [
              verticalSpaceLarge,
              ResponsiveText(
                "register".translate(),
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
              verticalSpaceLarge,
              Column(
                children: [
                  BaseTextField(
                    controller: usernameController,
                    hint: "username".translate(),
                    icon: IconlyBold.profile,
                    errorText: viewModel.usernameValidationMessage,
                  ),
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
              verticalSpaceLarge,
              Column(
                children: [
                  BaseButton(
                    icon: Icons.arrow_forward_sharp,
                    title: "create_account".translate(),
                    callback: () {
                      viewModel.register();
                    },
                    isLoading: viewModel.isBusy,
                  ),
                  SizedBox(height: screenHeight(context) * .03),
                  GestureDetector(
                    onTap: () {
                      viewModel.navigateToLogin();
                    },
                    child: ResponsiveText(
                      "or_sign_in".translate(),
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
  void onViewModelReady(RegisterViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(RegisterViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }

  @override
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
}
