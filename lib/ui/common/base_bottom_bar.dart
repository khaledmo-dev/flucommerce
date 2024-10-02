import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_text.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class BaseBottomBar extends StatelessWidget {
  const BaseBottomBar({
    super.key,
    required this.views,
    required this.currentIndex,
    required this.setIndex,
  });

  final List views;
  final int currentIndex;
  final Function(int index) setIndex;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < views.length; i++)
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    setIndex(i);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          currentIndex == i
                              ? views[i]['icon-bold']
                              : views[i]['icon-light'],
                          size: 26,
                          color: currentIndex == i
                              ? kcPrimaryColor
                              : kcBottomNavIconColor,
                        ),
                        verticalSpaceTiny,
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ResponsiveText(
                            (views[i]['title'] as String).translate(),
                            alignment: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
