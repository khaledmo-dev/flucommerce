import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'checkout_viewmodel.dart';

class CheckoutView extends StackedView<CheckoutViewModel> {
  const CheckoutView(this.items, {Key? key}) : super(key: key);
  final List<CartItem> items;
  @override
  Widget builder(
    BuildContext context,
    CheckoutViewModel viewModel,
    Widget? child,
  ) {
    late WebViewController controller;

    controller = WebViewController();
    controller.clearCache();
    WebViewCookieManager().clearCookies();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            var url = request.url;

            if (url.contains('order-received')) {
              var orderID =
                  url.substring(url.indexOf('order-received')).split('/')[1];
              viewModel.onOrderPlaced(orderID);
            }

            if (url.contains('checkout')) {
              return NavigationDecision.navigate;
            }

            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(viewModel.initialUrl()));

    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          "checkout".translate(),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  @override
  CheckoutViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CheckoutViewModel(items);
}
