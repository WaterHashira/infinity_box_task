part of 'product_list_bloc.dart';

abstract class ProductListEvent {
  const ProductListEvent();
}

class AllProductListRequested extends ProductListEvent {
  AllProductListRequested();
}

class FilterProductListRequested extends ProductListEvent {
  final String filter;

  FilterProductListRequested({required this.filter});
}

class SearchProductListRequested extends ProductListEvent {
  final String product;

  SearchProductListRequested({required this.product});
}
