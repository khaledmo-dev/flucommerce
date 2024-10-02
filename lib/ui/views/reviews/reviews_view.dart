import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'reviews_viewmodel.dart';

class ReviewsView extends StackedView<ReviewsViewModel> {
  const ReviewsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ReviewsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  ReviewsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ReviewsViewModel();
}
