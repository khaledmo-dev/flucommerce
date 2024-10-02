import 'package:flucommerce/data/models/order.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/orders/widgets/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'orders_viewmodel.dart';

class OrdersView extends StackedView<OrdersViewModel> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrdersViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: ResponsiveText(
            "orders".translate(),
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ),
        body: Builder(builder: (context) {
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }

          var orders = viewModel.orders;

          if (orders.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/$notFoundImage.png'),
                  verticalSpaceSmall,
                  ResponsiveText(
                    "no_orders".translate(),
                    alignment: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),

                    itemCount: orders.length + (viewModel.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (orders.length == index) {
                        return BaseButton(
                          title: "View More",
                          callback: () {
                            viewModel.fetchOrders();
                          },
                        );
                      }
                      var order = orders[index];
                      return OrderListTile(order: order);
                    },
                  ),
                ),
                viewModel.busy("paginate")
                    ? Center(
                        child: CircularProgressIndicator(
                          color: kcPrimaryColor,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  OrdersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrdersViewModel();
}

class OrderListTile extends StatelessWidget {
  const OrderListTile({
    super.key,
    required this.order,
  });
  final Order order;
  @override
  Widget build(BuildContext context) {
    // var localization = AppLocalizations.of(context)!;
    // var statuses = {
    //   'processing': "processing",
    //   'pending': "pending",
    //   'completed': "completed",
    //   'on-hold': "on_hold",
    //   'cancelled': "cancelled",
    //   'refunded': "refunded",
    //   'failed': "failed",
    //   'trash': "trash"
    // };
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderDetails(order),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kcCartItemBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      "${"order_number".translate()}: ${order.id}",
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    verticalSpaceTiny,
                    ResponsiveText(
                      "${"order_date".translate()}: ${DateTime.tryParse(order.dateCreatedGmt)?.toString().substring(0, 10)}",
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    verticalSpaceTiny,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ResponsiveText(
                          "${"total".translate()}: ${order.total}",
                          style: Theme.of(context).textTheme.titleMedium!,
                        ),
                        horizontalSpaceSmall,
                        Container(
                          decoration: BoxDecoration(
                            color: kcSecondaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: ResponsiveText(
                              order.status.translate(),
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              horizontalSpaceSmall,
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimeParse on String {
  DateTime dateTimeParse() {
    List<String> date = split('-');
    var year = date[0];
    var month = int.parse(date[1]) < 10 ? '0${date[1]}' : date[1];
    var day = int.parse(date[2]) < 10 ? '0${date[1]}' : date[1];
    return DateTime.parse('$year-$month-$day');
  }
}

extension FormatDate on DateTime {
  String formatDate() {
    return '$year-$month-$day';
  }
}
