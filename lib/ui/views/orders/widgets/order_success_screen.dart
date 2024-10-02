import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen(this.orderID, {super.key});
  final String orderID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  IconlyBold.buy,
                  color: kcButtonIconColor,
                  size: 40,
                ),
              ),
              verticalSpaceMedium,
              Text(
                "order_received".translate(),
                style: const TextStyle(fontSize: 24),
              ),
              verticalSpaceTiny,
              Text(
                "${"order_id".translate()}: $orderID",
                style: const TextStyle(fontSize: 20),
              ),
              verticalSpaceMedium,
              BaseButton(
                title: "view_order".translate(),
                callback: () {
                  locator<NavigationService>().back();
                  locator<NavigationService>().navigateToOrdersView();
                },
                width: screenWidth(context) * .5,
              ),
              verticalSpaceSmall,
              BaseButton(
                title: "back_to_home".translate(),
                callback: () {
                  locator<NavigationService>().back();
                },
                width: screenWidth(context) * .5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
