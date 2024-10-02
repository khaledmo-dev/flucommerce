import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flucommerce/ui/views/home/home_viewmodel.dart';
import 'package:flucommerce/ui/widgets/common/product_grid/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductsHorizontalList extends StatelessWidget {
  const ProductsHorizontalList(this.products, {super.key, required this.title});
  final List<Product> products;
  final String title;
  @override
  Widget build(BuildContext context) {
    var model = getParentViewModel<HomeViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                model.viewMore(title);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.translate(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: kcSecondaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      "view_all".translate(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            verticalSpaceSmall,
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...products.map(
                    (p) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: ProductCard(
                        product: p,
                        width: screenWidth(context) * .35,
                      ),
                    ),
                  ),
                  // if (products.length == 5)
                  //   Container(
                  //     decoration: BoxDecoration(
                  //       color: kcSecondaryColor,
                  //       borderRadius: BorderRadius.circular(25),
                  //       border: Border.all(color: kcSecondaryColor),
                  //     ),
                  //     width: screenWidth(context) * .35,
                  //     child: const AspectRatio(
                  //       aspectRatio: 1,
                  //       child: Center(child: Text("view all")),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
