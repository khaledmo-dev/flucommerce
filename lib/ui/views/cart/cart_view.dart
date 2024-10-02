import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({Key? key}) : super(key: key);

  @override
  bool get initialiseSpecialViewModelsOnce => true;

  @override
  bool get disposeViewModel => false;

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (viewModel.isBusy) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kcPrimaryColor,
                  size: 40,
                ),
              );
            }
            if (viewModel.hasError) {
              return Center(child: Text(viewModel.modelError.body));
            }
            return ValueListenableBuilder(
              valueListenable: viewModel.cartListenable,
              builder: (context, value, _) {
                var cartItems = value.values.toList();

                double price = cartItems.isEmpty
                    ? 0
                    : cartItems
                        .map((e) => double.parse(e.productPrice) * e.quantity)
                        .reduce((a, b) => a + b);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          var item = cartItems[index];
                          return CartListTile(item: item, deleteItem: false);
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * .14,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: kcSecondaryColor),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ResponsiveText(
                                    "total_price".translate(),
                                    style:
                                        Theme.of(context).textTheme.titleSmall!,
                                  ),
                                  ResponsiveText(
                                    '$price\$',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!,
                                  )
                                ],
                              ),
                              horizontalSpaceSmall,
                              Expanded(
                                child: BaseButton(
                                  // icon: ,
                                  title: "checkout".translate(),
                                  callback: () {
                                    viewModel.checkout(cartItems);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      locator<CartViewModel>();
}
