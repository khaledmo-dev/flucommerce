import 'package:flucommerce/data/models/order.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(this.order, {super.key});
  final Order order;
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: ResponsiveText(
        '${"order".translate()} #${order.id}',
        style: Theme.of(context).textTheme.bodySmall!,
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResponsiveText(
                  "order_status".translate(),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
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
            ),
            verticalSpaceSmall,
            Divider(color: kcSecondaryColor),
            verticalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveText(
                  "order_items".translate(),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                verticalSpaceSmall,
                ...order.lineItems.map(
                  (e) => LineItemTile(
                    item: e,
                    isCompleted: order.status == 'completed',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LineItemTile extends StatelessWidget {
  const LineItemTile({Key? key, required this.item, required this.isCompleted})
      : super(key: key);
  final LineItem item;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kcCartItemBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResponsiveText(
                  item.name!,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                if (isCompleted)
                  GestureDetector(
                    onTap: () async {
                      // await showModalBottomSheet(
                      //   isScrollControlled: true,
                      //   context: context,
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(40.0),
                      //       topRight: Radius.circular(40.0),
                      //     ),
                      //   ),
                      //   backgroundColor: kcButtonIconColor,
                      //   builder: (_) => ReviewBottomSheet(
                      //     productID: item.productId,
                      //   ),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kcSecondaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: ResponsiveText(
                          "leave_review".translate(),
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResponsiveText(
                  "${"total".translate()}: ${item.total}",
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kcSecondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ResponsiveText(
                      item.quantity.toString(),
                      style: Theme.of(context).textTheme.headlineSmall!,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
