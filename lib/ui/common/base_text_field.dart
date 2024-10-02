import 'package:flucommerce/ui/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hint,
    this.icon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.errorText,
    this.inputFormatters,
    this.readOnly = false,
    this.isPassword = false,
    this.filled = true,
    this.unfocusOnTapOutside = true,
    this.node,
    this.onChange,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hint;
  final IconData? icon;
  final Widget? suffixIcon;
  final Function? validator;
  final Function? onTap;
  final Function(String text)? onChange;
  final FocusNode? node;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  final bool readOnly;
  final bool isPassword;
  final bool filled;
  final bool unfocusOnTapOutside;
  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness;
    var responsiveSize = 24 * (screenWidth(context) / 4) / 100;
    var theme = Theme.of(context);
    final circularBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );

    return TapRegion(
      onTapOutside: node != null && unfocusOnTapOutside
          ? (event) => node!.unfocus()
          : null,
      child: TextFormField(
        forceErrorText: errorText,
        controller: controller,
        onChanged: onChange,
        focusNode: node,
        keyboardType: keyboardType,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        obscureText: isPassword,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        style: theme.textTheme.bodySmall!.copyWith(
            fontSize: theme.textTheme.bodySmall!.fontSize! *
                (screenWidth(context) / 3.5) /
                100),
        cursorColor: kcPrimaryColor,
        decoration: InputDecoration(
          isDense: true,
          labelText: hint,
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: theme.textTheme.titleMedium!.fontSize! *
                  (screenWidth(context) / 3.5) /
                  100),
          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: theme.textTheme.titleMedium!.fontSize! *
                  (screenWidth(context) / 3.5) /
                  100),
          suffixIcon: suffixIcon,
          prefixIcon: icon == null
              ? null
              : Icon(
                  icon!,
                  size: responsiveSize,
                  color: kcPrimaryColor,
                ),
          filled: filled,
          fillColor: kcSecondaryColor,
          border: circularBorder.copyWith(
            borderSide: const BorderSide(color: kcLightGrey),
          ),
          errorBorder: circularBorder.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: circularBorder.copyWith(
            borderSide: BorderSide(color: kcPrimaryColor),
          ),
          enabledBorder: circularBorder.copyWith(
            borderSide: BorderSide(color: kcSecondaryColor),
          ),
        ),
      ),
    );
  }
}
