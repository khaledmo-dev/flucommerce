import 'package:flucommerce/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flucommerce/ui/common/skeleton.dart';

class HomeViewLoading extends StatelessWidget {
  const HomeViewLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            Skeleton(
              height: screenHeight(context) * .07,
              width: double.infinity,
            ),
            verticalSpaceSmall,
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsetsDirectional.only(end: 12),
                    child: Column(
                      children: [
                        Skeleton(
                          height: 60,
                          width: 60,
                          radius: 100,
                        ),
                        verticalSpaceTiny,
                        Skeleton(
                          height: 20,
                          width: 60,
                          radius: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  childAspectRatio: 1 / 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Skeleton(
                            height: constraints.maxWidth,
                            width: constraints.maxWidth,
                            radius: 25,
                          ),
                          Skeleton(
                            height: 20,
                            width: constraints.maxWidth / 1.3,
                            radius: 5,
                          ),
                          Skeleton(
                            height: 20,
                            width: constraints.maxWidth / 1.7,
                            radius: 5,
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
