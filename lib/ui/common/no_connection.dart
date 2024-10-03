import 'package:flucommerce/ui/common/common.dart';
import 'package:flutter/material.dart';


class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({
    super.key,
    required this.reload,
  });

  final Function reload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/internet-offline.png',
            width:screenWidth(context) * .5,
          ),
          verticalSpaceSmall,
          ResponsiveText(
            'An error ocured\n Check your internet and try again',
            alignment: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          verticalSpaceSmall,
          IconButton(
            onPressed: () {
              reload();
            },
            icon: ResponsiveIcon(
              Icons.refresh,
              color: kcPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
