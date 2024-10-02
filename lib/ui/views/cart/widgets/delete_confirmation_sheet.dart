import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/base_button.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteBottomSheet extends StatelessWidget {
  const ConfirmDeleteBottomSheet(this.item,
      {super.key, required this.deleteItem});

  final CartItem item;
  final Function(CartItem) deleteItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "localization.remove_cart_item_confirmation",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Divider(color: kcSecondaryColor),
          verticalSpaceSmall,
          CartListTile(item: item, deleteItem: true),
          Divider(color: kcSecondaryColor),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                child: BaseButton(
                  callback: () {
                    Navigator.of(context).pop();
                  },
                  title: "cancel",
                  iconColor: Colors.grey,
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: BaseButton(
                  callback: () {
                    deleteItem(item);
                    Navigator.of(context).pop();
                  },
                  title: "confirm_delete",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
