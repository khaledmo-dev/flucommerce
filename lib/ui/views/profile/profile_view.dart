import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/common.dart';
import 'package:flucommerce/ui/views/profile/profile_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'profile_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'firstName'),
    FormTextField(name: 'lastName'),
    FormTextField(name: 'address'),
    FormTextField(name: 'phone'),
  ],
)
class ProfileView extends StackedView<ProfileViewModel> with $ProfileView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text("profile".translate())),
      body: Builder(
        builder: (context) {
          if (viewModel.isBusy) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: kcPrimaryColor,
                size: 40,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24.0),
                  children: [
                    BaseTextField(
                      controller: firstNameController,
                      hint: "first_name".translate(),
                    ),
                    verticalSpaceSmall,
                    BaseTextField(
                      controller: lastNameController,
                      hint: "second_name".translate(),
                    ),
                    verticalSpaceSmall,
                    BaseTextField(
                      controller: addressController,
                      hint: "address".translate(),
                    ),
                    verticalSpaceSmall,
                    BaseTextField(
                      controller: phoneController,
                      hint: "phone".translate(),
                    ),
                    verticalSpaceSmall,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: BaseButton(
                  title: "confirm".translate(),
                  isLoading: viewModel.isBusy,
                  callback: () {
                    viewModel.editProfile();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(ProfileViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
