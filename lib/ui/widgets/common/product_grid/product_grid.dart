import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/ui/widgets/common/favorite_button/favorite_button.dart';
import 'package:flucommerce/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flucommerce/ui/common/common.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid(
    this.products, {
    super.key,
    this.isPaginating = false,
    this.fetchMore,
  });
  final List<Product> products;
  final bool isPaginating;
  final Function? fetchMore;
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700;
    int columnCount = isTablet ? 3 : 2;

    int rowCount = (products.length / columnCount).ceil();

    bool remainder = products.length % columnCount != 0;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: rowCount +
          (((isPaginating || fetchMore != null) && !remainder) ? 1 : 0),
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth =
                (constraints.maxWidth - (12 * (columnCount - 1))) / columnCount;

            List<Product> rowProducts =
                products.skip(index * columnCount).take(columnCount).toList();

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...rowProducts.mapIndexed(
                    (i, product) {
                      bool isLast = i == columnCount - 1;
                      return Padding(
                        padding:
                            EdgeInsetsDirectional.only(end: isLast ? 0 : 12),
                        child: ProductCard(
                          product: product,
                          width: cardWidth,
                        ),
                      );
                    },
                  ),
                  if (isPaginating &&
                      index == (remainder ? (rowCount - 1) : rowCount))
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        width: cardWidth,
                        height: cardWidth,
                        decoration: BoxDecoration(
                          color: kcSecondaryColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: kcSecondaryColor),
                        ),
                        child: Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: kcPrimaryColor,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  if (!isPaginating &&
                      fetchMore != null &&
                      index == (remainder ? (rowCount - 1) : rowCount))
                    GestureDetector(
                      onTap: () {
                        fetchMore!();
                      },
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          width: cardWidth,
                          height: cardWidth,
                          decoration: BoxDecoration(
                            color: kcSecondaryColor,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: kcSecondaryColor),
                          ),
                          child: const Center(child: Text("See More")),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.width,
  });

  final Product product;
  final double? width;
  @override
  Widget build(BuildContext context) {
    double ratePercentage = double.parse(product.averageRating) / 5;

    return GestureDetector(
      onTap: () {
        locator<NavigationService>()
            .navigateToProductDetailsView(product: product);
      },
      child: Container(
        color: Colors.transparent,
        width: width,
        margin: const EdgeInsetsDirectional.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kcSecondaryColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: kcSecondaryColor),
                    ),
                    child: product.images.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              product.images.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          )
                        : const Center(child: ResponsiveIcon(Icons.image)),
                  ),
                ),
                PositionedDirectional(
                  end: 10,
                  top: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Transform.scale(
                      scale: .9,
                      child: Center(
                        child: IconTheme(
                          data: const IconThemeData(color: Colors.white),
                          child: FavoriteButton(product),
                        ),
                      ),
                    ),
                  ),
                ),
                if (product.onSale && product.type != ProductType.grouped)
                  PositionedDirectional(
                    start: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ResponsiveText(
                          "${calculateSalePercentage(product.salePrice, product.regularPrice)}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            verticalSpaceTiny,
            FittedBox(
              fit: BoxFit.scaleDown,
              clipBehavior: Clip.hardEdge,
              alignment: AlignmentDirectional.centerStart,
              child: ResponsiveText(
                product.name,
                style: Theme.of(context).textTheme.bodySmall!,
                maxLines: 1,
              ),
            ),
            verticalSpaceTiny,
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => LinearGradient(
                      stops: [ratePercentage, ratePercentage],
                      colors: [
                        kcPrimaryColor,
                        kcSecondaryColor,
                      ],
                    ).createShader(bounds),
                    child: ResponsiveIcon(
                      IconlyBold.star,
                      color: kcPrimaryColor,
                      size: 20,
                    ),
                  ),
                  horizontalSpaceTiny,
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: ResponsiveText(
                      product.averageRating,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 1.5),
                      alignment: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            verticalSpaceTiny,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (product.onSale && product.type != ProductType.grouped)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 4.0),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: ResponsiveText(
                        '${product.regularPrice}\$',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  height: 1.5,
                                ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      product.onSale ? product.price : product.htmlPrice,
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
