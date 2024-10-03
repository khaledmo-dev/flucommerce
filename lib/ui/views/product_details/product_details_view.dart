import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/services/translation_service.dart';
import 'package:flucommerce/ui/common/common.dart';
import 'package:flucommerce/ui/views/product_details/product_details_viewmodel.dart';
import 'package:flucommerce/ui/widgets/common/attributes_section/attributes_section.dart';
import 'package:flucommerce/ui/widgets/common/favorite_button/favorite_button.dart';
import 'package:flucommerce/ui/widgets/common/grouped_products/grouped_products.dart';
import 'package:flucommerce/ui/widgets/common/image_section/image_section.dart';
import 'package:flucommerce/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailsView extends StackedView<ProductDetailsViewModel> {
  const ProductDetailsView(this.product, {Key? key}) : super(key: key);
  final Product product;
  @override
  Widget builder(
    BuildContext context,
    ProductDetailsViewModel viewModel,
    Widget? child,
  ) {
    double ratePercentage = double.parse(product.averageRating) / 5;
    if (viewModel.hasError) {
      return NoConnectionWidget(reload: viewModel.initialise);
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight(context) * .85,
                  child: ListView(
                    // controller: _controller,
                    children: [
                      Stack(
                        children: [
                          ImageSection(
                            viewModel.images,
                            controller: viewModel.imagesController,
                          ),
                          if (product.onSale &&
                              product.type != ProductType.grouped &&
                              product.salePrice.isNotEmpty)
                            PositionedDirectional(
                              end: 30,
                              top: 30,
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
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ResponsiveText(
                                          product.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!,
                                        ),
                                      ),
                                      verticalSpaceSmall,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: kcSecondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: ResponsiveText(
                                                "${product.totalSales} ${"sold".translate()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!,
                                              ),
                                            ),
                                          ),
                                          horizontalSpaceSmall,
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              // MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       ReviewsScreen(
                                              //           product: product),
                                              // ),
                                              // );
                                            },
                                            child: Row(
                                              children: [
                                                ShaderMask(
                                                  blendMode: BlendMode.srcIn,
                                                  shaderCallback:
                                                      (Rect bounds) =>
                                                          LinearGradient(
                                                    stops: [
                                                      ratePercentage,
                                                      ratePercentage
                                                    ],
                                                    colors: [
                                                      kcPrimaryColor,
                                                      kcSecondaryColor,
                                                    ],
                                                  ).createShader(bounds),
                                                  child: const ResponsiveIcon(
                                                      IconlyBold.star),
                                                ),
                                                horizontalSpaceTiny,
                                                ResponsiveText(
                                                  "${product.averageRating} (${product.ratingCount})",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      verticalSpaceTiny,
                                      ResponsiveText(
                                        product.stockStatus,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!,
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    FavoriteButton(product),
                                    IconButton(
                                      onPressed: () {
                                        // Share.share(product.permalink);
                                      },
                                      icon: const ResponsiveIcon(Icons.share),
                                    )
                                  ],
                                )
                              ],
                            ),
                            if (product.type == ProductType.variable)
                              viewModel.isBusy
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : AttributesSection(
                                      attributes: viewModel.attributes,
                                      combinations: viewModel.combinations,
                                      selectedVariation: viewModel
                                          .selectedVariations[product.id],
                                      selectVariation: (variation) {
                                        viewModel.selectVariation(
                                          product.id,
                                          variation,
                                        );
                                      },
                                    ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(color: kcSecondaryColor),
                                ResponsiveText(
                                  "description".translate(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!,
                                ),
                                verticalSpaceTiny,
                                Html(
                                  data: product.description,
                                  style: {
                                    '*': Style(
                                      fontSize: FontSize(
                                        Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .fontSize! *
                                            (screenWidth(context) / 3.5) /
                                            100,
                                      ),
                                      padding: HtmlPaddings.all(0),
                                      margin: Margins.all(0),
                                    ),
                                  },
                                ),
                                Divider(color: kcSecondaryColor),
                              ],
                            ),
                            verticalSpaceSmall,
                            if (product.type == ProductType.grouped)
                              GroupedProducts(
                                products: viewModel.groupedProducts,
                              ),
                            verticalSpaceSmall,
                            if (product.type != ProductType.external)
                              const _QuantityController(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _BottomActionSection(product),
              ],
            ),
            PositionedDirectional(
              start: 15,
              top: 15,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const ResponsiveIcon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProductDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductDetailsViewModel(product);
}

class _BottomActionSection extends StatelessWidget {
  const _BottomActionSection(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var viewModel =
        getParentViewModel<ProductDetailsViewModel>(context, listen: true);
    var regularPrice =
        double.tryParse(product.regularPrice) ?? 0 * viewModel.quantity;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: kcSecondaryColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveText(
                    "total_price".translate(),
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  Row(
                    children: [
                      if (product.onSale && product.type != ProductType.grouped)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 4.0),
                          child: ResponsiveText(
                            '$regularPrice\$',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        ),
                      ResponsiveText(
                        '${viewModel.price}\$',
                        style: Theme.of(context).textTheme.headlineSmall!,
                      )
                    ],
                  )
                ],
              ),
              horizontalSpaceMedium,
              Expanded(
                child: BaseButton(
                  icon: product.type == ProductType.external
                      ? Icons.link_rounded
                      : IconlyBold.bag,
                  title: product.type == ProductType.external
                      ? product.buttonText
                      : "add",
                  callback: () {
                    viewModel.confirm();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuantityController extends StatelessWidget {
  const _QuantityController();

  @override
  Widget build(BuildContext context) {
    var viewModel =
        getParentViewModel<ProductDetailsViewModel>(context, listen: true);
    return Row(
      children: [
        ResponsiveText(
          "quantity".translate(),
          style: Theme.of(context).textTheme.headlineSmall!,
        ),
        horizontalSpaceSmall,
        Container(
          decoration: BoxDecoration(
            color: kcSecondaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => viewModel.decreaseQuantity(),
                icon: const ResponsiveIcon(Icons.remove),
                splashRadius: 0.1,
              ),
              ResponsiveText(
                viewModel.quantity.toString(),
                style: Theme.of(context).textTheme.headlineSmall!,
              ),
              IconButton(
                onPressed: () => viewModel.increaseQuantity(),
                icon: const ResponsiveIcon(Icons.add),
                splashRadius: 0.1,
              )
            ],
          ),
        )
      ],
    );
  }
}
