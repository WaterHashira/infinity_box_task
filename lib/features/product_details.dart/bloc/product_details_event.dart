part of 'product_details_bloc.dart';

abstract class AddToCartEvent {
  const AddToCartEvent();
}

class AddToCartRequested extends AddToCartEvent {
  final String currUserEmail;
  final int productId;
  AddToCartRequested({required this.currUserEmail, required this.productId});
}
