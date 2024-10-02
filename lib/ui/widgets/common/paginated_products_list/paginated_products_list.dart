import 'package:flucommerce/data/models/product.dart';
import 'package:flucommerce/ui/widgets/common/product_grid/product_grid.dart';
import 'package:flutter/material.dart';

class PaginatedProductsList extends StatefulWidget {
  const PaginatedProductsList({
    super.key,
    required this.products,
    required this.paginate,
    this.isLoading = false,
  });
  final List<Product> products;
  final Function paginate;
  final bool isLoading;
  @override
  State<PaginatedProductsList> createState() => _PaginatedProductsListState();
}

class _PaginatedProductsListState extends State<PaginatedProductsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
        child: ProductGrid(
          widget.products,
          isPaginating: widget.isLoading,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      widget.paginate();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
