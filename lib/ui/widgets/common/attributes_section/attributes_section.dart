import 'package:flucommerce/data/models/product_variation.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/alert_message.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class AttributesSection extends StatefulWidget {
  const AttributesSection({
    super.key,
    required this.attributes,
    required this.combinations,
    required this.selectVariation,
    required this.selectedVariation,
    this.controller,
  });

  final Map<String, Set<String>> attributes;
  final Map<ProductVariation, List<String>> combinations;
  final ProductVariation? selectedVariation;
  final Function(ProductVariation? variation) selectVariation;

  final ScrollController? controller;
  @override
  State<AttributesSection> createState() => _AttributesSectionState();
}

class _AttributesSectionState extends State<AttributesSection> {
  // ------------------------------------------ // ------------------------------------------ //
  // This block of code adds the functionality of displaying to the user the available variations
  // also can be described as the combination of attributes

  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    if (widget.selectedVariation == null) {
      selectedOptions = List.filled(widget.attributes.length, '');
    } else {
      selectedOptions =
          widget.selectedVariation!.attributes.map((e) => e.option).toList();
    }
  }

  bool isOptionSelected(String option) => selectedOptions.contains(option);

  selectOption(int index, String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions[index] = "";
    } else {
      selectedOptions[index] = option;
    }

    // check if all attributes are selected and a variation is matched
    if (!selectedOptions.contains('')) {
      var variation = widget.combinations.entries
          .firstWhere((e) => listEquals(e.value, selectedOptions))
          .key;
      widget.selectVariation(variation);
    } else {
      widget.selectVariation(null);
    }
  }

  bool isOptionSelectable(int index, String option) {
    var list = List<String>.from(selectedOptions);

    // check if the selected options match one of the product variable attributes
    return widget.combinations.entries
        // filter out the out-of-stock variations
        .where((e) => e.key.stockStatus != "outofstock")
        .any(
      (entry) {
        list[index] = option;
        // insure that there is a matching variation with selected options
        return entry.value.containsAll(list.where((e) => e.isNotEmpty));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var localization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: kcSecondaryColor),
        if (selectedOptions.any((element) => element == '')) ...[
          MessageAlert(message: "select_variation_display_price".translate()),
          verticalSpaceSmall
        ],
        ...widget.attributes.entries.mapIndexed(
          (index, attribue) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveText(
                  attribue.key,
                  style: Theme.of(context).textTheme.headlineSmall!,
                ),
                verticalSpaceTiny,
                Wrap(
                  children: attribue.value.map(
                    (option) {
                      bool isSelectable = isOptionSelectable(index, option);
                      bool isSelected = isOptionSelected(option);
                      return GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              if (isSelectable) {
                                selectOption(index, option);
                              }
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              end: 6.0, bottom: 6.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: kcSecondaryColor, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: isOptionSelected(option)
                                  ? kcPrimaryColor
                                  : null),
                          child: IntrinsicWidth(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ResponsiveText(
                                    option,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: isSelected
                                              ? kcButtonIconColor
                                              : null,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                  ),
                                ),
                                if (!isSelectable && !isSelected)
                                  Container(color: kcPrimaryColor, height: 2),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                verticalSpaceTiny
              ],
            );
          },
        ),
      ],
    );
  }
}

extension IterableExtensions<E> on Iterable<E> {
  bool containsAll(Iterable<E> elements) {
    for (final e in elements) {
      if (!contains(e)) return false;
    }

    return true;
  }
}
