import 'package:carousel_slider/carousel_slider.dart';
import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flucommerce/ui/common/responsive_icon.dart';
import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class ImageSection extends StatefulWidget {
  const ImageSection(
    this.images, {
    Key? key,
    this.width,
    this.controller,
  }) : super(key: key);
  final List<String> images;
  final CarouselSliderController? controller;

  final double? width;
  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  var page = 0;

  @override
  Widget build(BuildContext context) {
    List images = widget.images;
    return Container(
      color: kcSecondaryColor,
      width: widget.width ?? screenWidth(context),
      height: widget.width ?? screenWidth(context),
      constraints: BoxConstraints(maxHeight: screenHeight(context) * .5),
      child: images.isNotEmpty
          ? Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider(
                  carouselController: widget.controller,
                  items: images
                      .map(
                        (image) => Padding(
                          padding:
                              const EdgeInsets.all(24.0).copyWith(bottom: 34),
                          child: Image.network(
                            image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    aspectRatio: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        page = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: _DotsIndicator(
                    length: images.length,
                    page: page,
                  ),
                )
              ],
            )
          : const ResponsiveIcon(Icons.image),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({Key? key, required this.length, required this.page})
      : super(key: key);
  final int length;
  final int page;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < length; i++)
            AnimatedContainer(
              margin: const EdgeInsetsDirectional.only(end: 8.0),
              duration: const Duration(milliseconds: 350),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: i == page ? kcPrimaryColor : kcButtonIconColor,
              ),
              width: i == page ? 30 : 10,
              height: 10,
            )
        ],
      ),
    );
  }
}
