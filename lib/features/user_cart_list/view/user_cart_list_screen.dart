import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/user_cart_list/bloc/user_cart_list_bloc.dart';
import 'package:infinity_box_task/features/user_cart_list/user_cart_list_repository.dart';
import 'package:infinity_box_task/features/user_cart_list/view/widgets/cart_card.dart';
import 'package:infinity_box_task/utils/color_constants.dart';
import 'package:infinity_box_task/widgets/custom_bottom_navigation_bar.dart';
import 'package:infinity_box_task/widgets/custom_snack_bar.dart';
import 'package:infinity_box_task/widgets/loading_overlay.dart';

class UserCartListScreen extends StatelessWidget {
  static const id = 'UserCartListScreen';

  String token;
  UserCartListScreen({super.key, required this.token});

  List<Product>? productList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<UserCartListBloc>(
        create: (_) => UserCartListBloc(UserCartListRepository())
          ..add(UserCartListRequested(token: token)),
        child: BlocConsumer<UserCartListBloc, UserCartListState>(
          listener: (context, state) {
            if (state is UserCartListSuccess) {
              productList = state.userCartList;
            } else if (state is UserCartListFailure) {
              showErrorSnackBar('Oops! Something went wrong');
            } else if (state is DeleteCartItemSuccess) {
              showSuccessSnackBar('Deleted Successfully');
            } else if (state is DeleteCartItemFailure) {
              showErrorSnackBar(state.err);
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is UserCartListLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Your Cart'),
                ),
                bottomNavigationBar: const CustomBottomNavigationBar(),
                body: (productList == null)
                    ? Center(
                        child: Text(
                          'No items found',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: ListView.builder(
                                itemCount: productList!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      CartCard(
                                          product: productList![index],
                                          deleteOnTap: () {
                                            BlocProvider.of<UserCartListBloc>(
                                                    context)
                                                .add(DeleteCartItem(
                                                    token: token,
                                                    id: productList![index]
                                                        .id));
                                          }),
                                      const SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        ColorConstants.inactiveRatingBarColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 0.5),
                                  ),
                                  child: Center(
                                    child: Text(
                                        'Total Price: ${totalPriceCalculator()}'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  //calculates the total price of all the products in the user's cart
  double totalPriceCalculator() {
    double totalPrice = 0;
    if (productList != null) {
      for (Product pro in productList!) {
        totalPrice += pro.price;
      }
    }
    return totalPrice;
  }
}
