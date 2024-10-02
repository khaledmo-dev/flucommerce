import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/main.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: ResponsiveText("settings".translate())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(color: kcSecondaryColor),
            ListTileTheme(
              iconColor: kcPrimaryColor,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      viewModel.navigateToProfile();
                    },
                    leading: const ResponsiveIcon(IconlyBold.profile),
                    title: ResponsiveText(
                      "profile".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    trailing: const ResponsiveIcon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      viewModel.navigateToFavorites();
                    },
                    leading: const ResponsiveIcon(IconlyBold.heart),
                    title: ResponsiveText(
                      "wish_slist".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    trailing: const ResponsiveIcon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      viewModel.navigateToOrders();
                    },
                    leading: const ResponsiveIcon(IconlyBold.buy),
                    title: ResponsiveText(
                      "orders".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    trailing: const ResponsiveIcon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      viewModel.navigateToRefundScreen();
                    },
                    leading: const ResponsiveIcon(IconlyBold.document),
                    title: ResponsiveText(
                      "refund_policy".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    trailing: const ResponsiveIcon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      viewModel.navigateToContactScreen();
                    },
                    leading: const ResponsiveIcon(IconlyBold.call),
                    title: ResponsiveText(
                      "contact_us".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    trailing: const ResponsiveIcon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      viewModel.toggleTheme();
                    },
                    leading: const ResponsiveIcon(IconlyBold.show),
                    title: ResponsiveText(
                      "dark_mode".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    trailing: CupertinoSwitch(
                      value: !isLightTheme,
                      activeColor: kcPrimaryColor,
                      thumbColor: kcButtonIconColor,
                      onChanged: (value) {
                        viewModel.toggleTheme();
                      },
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return const SetLanguageSheet();
                        },
                      );
                    },
                    leading: const ResponsiveIcon(Icons.abc),
                    title: ResponsiveText(
                      "language".translate(),
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    // trailing:
                  ),
                  if (!viewModel.isGuest)
                    ListTile(
                      onTap: () {
                        viewModel.logout();
                      },
                      leading: const ResponsiveIcon(
                        IconlyLight.logout,
                        color: Colors.red,
                      ),
                      title: ResponsiveText(
                        "logout".translate(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  if (viewModel.isGuest)
                    ListTile(
                      onTap: () {
                        viewModel.navigateToLogin();
                      },
                      leading: const ResponsiveIcon(
                        IconlyLight.login,
                        color: Colors.green,
                      ),
                      title: ResponsiveText(
                        "login".translate(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}

class SetLanguageSheet extends StatefulWidget {
  const SetLanguageSheet({super.key});

  @override
  State<SetLanguageSheet> createState() => _SetLanguageSheetState();
}

class _SetLanguageSheetState extends State<SetLanguageSheet> {
  final LocalStorageService storage = locator<LocalStorageService>();
  late bool isArabic;

  @override
  void initState() {
    isArabic = storage.lang == 'ar';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isArabic = true;
                  langNotifier.value = 'ar';
                  storage.lang = 'ar';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcSecondaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: kcButtonIconColor,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const ResponsiveText('AR'),
                        ),
                        horizontalSpaceSmall,
                        ResponsiveText("arabic".translate()),
                      ],
                    ),
                    IgnorePointer(
                      child: Radio(
                        value: true,
                        groupValue: isArabic,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ),
            ),
            verticalSpaceSmall,
            GestureDetector(
              onTap: () {
                setState(() {
                  isArabic = false;
                  langNotifier.value = 'en';
                  storage.lang = 'en';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcSecondaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: kcButtonIconColor,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const ResponsiveText('EN'),
                        ),
                        horizontalSpaceSmall,
                        ResponsiveText("english".translate()),
                      ],
                    ),
                    IgnorePointer(
                      child: Radio(
                        value: false,
                        groupValue: isArabic,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
