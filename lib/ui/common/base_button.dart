import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatefulWidget {
  const BaseButton({
    Key? key,
    this.icon,
    this.iconColor,
    required this.title,
    required this.callback,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final IconData? icon;
  final Color? iconColor;
  final String title;
  final Function callback;
  final bool isLoading;
  final double? width;
  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (!widget.isLoading) {
          widget.callback();
        }
      },
      color:
          widget.iconColor ?? (widget.isLoading ? Colors.grey : kcPrimaryColor),
      elevation: 0,
      minWidth: widget.width ?? double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon != null
              ? ResponsiveIcon(
                  widget.icon!,
                  color: kcButtonIconColor,
                )
              : const SizedBox.shrink(),
          widget.icon != null ? horizontalSpaceSmall : const SizedBox.shrink(),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: ResponsiveText(
              widget.title.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge!,
            ),
          )
        ],
      ),
    );
  }
}
