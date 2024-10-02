import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/cart/cart_viewmodel.dart';
import 'package:flucommerce/ui/views/cart/widgets/delete_confirmation_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    super.key,
    required this.item,
    required this.deleteItem,
  });

  final CartItem item;
  final bool deleteItem;
  @override
  Widget build(BuildContext context) {
    CartViewModel? model;
    if (deleteItem == false) {
      model = getParentViewModel<CartViewModel>(context);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: kcCartItemBackgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0, 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: width * .3,
                    height: width * .3,
                    constraints:
                        const BoxConstraints(maxHeight: 200, maxWidth: 200),
                    color: kcSecondaryColor,
                    child: item.image != null
                        ? Image.network(item.image!)
                        : const ResponsiveIcon(Icons.image),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 24.0, 12.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ResponsiveText(
                              item.productName,
                              style: Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ),
                          if (!deleteItem)
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  backgroundColor: kcButtonIconColor,
                                  builder: (_) {
                                    return ConfirmDeleteBottomSheet(
                                      item,
                                      deleteItem:
                                          getParentViewModel<CartViewModel>(
                                                  context)
                                              .deleteItem,
                                    );
                                  },
                                );
                              },
                              icon: const ResponsiveIcon(
                                IconlyLight.delete,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                      // attributes if the product is variable
                      if (item.variationTitle != null)
                        Column(
                          children: [
                            verticalSpaceSmall,
                            ResponsiveText(
                              item.variationTitle!,
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                          ],
                        ),
                      verticalSpaceSmall,
                      !deleteItem
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ResponsiveText(
                                  "${item.productPrice}\$",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: kcSecondaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        iconSize: 12,
                                        onPressed: () {
                                          model!.decreaseQuantity(item);
                                        },
                                        icon:
                                            const ResponsiveIcon(Icons.remove),
                                        splashRadius: 0.1,
                                      ),
                                      ResponsiveText(
                                        item.quantity.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!,
                                      ),
                                      IconButton(
                                        iconSize: 12,
                                        onPressed: () {
                                          model!.increaseQuantity(item);
                                        },
                                        icon: const ResponsiveIcon(Icons.add),
                                        splashRadius: 0.1,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ResponsiveText(
                                  "${item.productPrice}\$",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: kcSecondaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: ResponsiveText(
                                      item.quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!,
                                    ),
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
