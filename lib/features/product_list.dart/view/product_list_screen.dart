import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/product_list.dart/bloc/product_list_bloc.dart';
import 'package:infinity_box_task/features/product_list.dart/product_list_repository.dart';
import 'package:infinity_box_task/features/product_list.dart/view/widgets/product_card.dart';
import 'package:infinity_box_task/utils/color_constants.dart';
import 'package:infinity_box_task/widgets/custom_bottom_navigation_bar.dart';
import 'package:infinity_box_task/widgets/custom_snack_bar.dart';
import 'package:infinity_box_task/widgets/loading_overlay.dart';

class ProductListScreen extends StatefulWidget {
  static const id = 'ProductListScreen';

  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  CategoryChipDeatils categoryChipDeatils = CategoryChipDeatils();
  List<Product> allProductsList = [];
  List<Product> productsList = [];

  Color activeChipTextColor = Colors.black;
  Color activeChipBackgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocProvider<ProductListBloc>(
        create: (_) => ProductListBloc(ProductListRepository())
          ..add(AllProductListRequested()),
        child: BlocConsumer<ProductListBloc, ProductListState>(
          listener: (context, state) {
            if (state is AllProductListSuccess) {
              productsList = state.allProductsList;
              allProductsList = state.allProductsList;
              categoryChipDeatils.categories = state.productCategoryList;
              categoryChipDeatils.count = state.productCategoryList.length;
            } else if (state is AllProductListFailure) {
              showErrorSnackBar('Oops! Something went Wrong');
            } else if (state is FilterProductListSuccess) {
              productsList = state.filterProductsList;
            } else if (state is FilterProductListFaliure) {
              showErrorSnackBar('Oops! Something went Wrong');
            } else if (state is SearchProductListSuccess) {
              productsList = state.searchProductsList;
            } else if (state is SearchProductListFaliure) {
              showErrorSnackBar('Oops! Something went Wrong');
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is ProductListLoading,
              child: Scaffold(
                appBar: AppBar(),
                bottomNavigationBar: const CustomBottomNavigationBar(),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('Search'),
                              onPressed: () {},
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              child: const Text('Cart'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Expanded(
                                flex: 1, child: Icon(Icons.filter_list)),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 8,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    categoryChipDeatils.categories.length,
                                itemBuilder: ((context, index) {
                                  return Row(
                                    children: <Widget>[
                                      FilterChip(
                                          label: Text(
                                            categoryChipDeatils
                                                .categories[index],
                                          ),
                                          labelStyle: TextStyle(
                                              color: categoryChipDeatils
                                                  .chipTextColors[index]),
                                          backgroundColor: categoryChipDeatils
                                              .chipBackgroundColors[index],
                                          selected: categoryChipDeatils
                                              .isSelected[index],
                                          onSelected: (val) {
                                            if (val) {
                                              setState(() {
                                                categoryChipDeatils
                                                        .chipTextColors[index] =
                                                    activeChipTextColor;

                                                categoryChipDeatils
                                                            .chipBackgroundColors[
                                                        index] =
                                                    activeChipBackgroundColor;

                                                categoryChipDeatils.isSelected =
                                                    List.filled(
                                                        categoryChipDeatils
                                                            .count,
                                                        false);
                                                categoryChipDeatils
                                                    .isSelected[index] = true;
                                              });
                                              BlocProvider.of<ProductListBloc>(
                                                context,
                                                listen: false,
                                              ).add(FilterProductListRequested(
                                                  filter: categoryChipDeatils
                                                      .categories[index]));
                                            } else {
                                              setState(() {
                                                categoryChipDeatils
                                                        .chipTextColors[index] =
                                                    ColorConstants
                                                        .activeRatingBarColor;

                                                categoryChipDeatils
                                                            .chipBackgroundColors[
                                                        index] =
                                                    ColorConstants
                                                        .inactiveRatingBarColor;

                                                categoryChipDeatils
                                                    .isSelected[index] = false;

                                                productsList = allProductsList;
                                              });
                                            }
                                          }),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: AnimationLimiter(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(
                              productsList.length,
                              (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: ProductCard(
                                          product: productsList[index]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//its instance contains the details of all the current category filters
class CategoryChipDeatils {
  int count;
  List<String> categories;
  List<Color> chipBackgroundColors;
  List<Color> chipTextColors;
  List<bool> isSelected;

  CategoryChipDeatils(
      {this.count = 0,
      this.categories = const <String>[],
      this.chipBackgroundColors = const <Color>[],
      this.chipTextColors = const <Color>[],
      this.isSelected = const <bool>[]}) {
    chipBackgroundColors =
        List.filled(count, ColorConstants.inactiveRatingBarColor);
    chipTextColors = List.filled(count, ColorConstants.activeRatingBarColor);
    isSelected = List.filled(count, false);
  }
}
