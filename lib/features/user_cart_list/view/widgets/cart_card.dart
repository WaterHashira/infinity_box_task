import 'package:flutter/material.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/product_details.dart/view/product_details_screen.dart';
import 'package:infinity_box_task/utils/color_constants.dart';

class CartCard extends StatelessWidget {
  final Product product;
  final VoidCallback deleteOnTap;
  const CartCard({super.key, required this.product, required this.deleteOnTap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.id,
            arguments: {'product': product}),
        child: Container(
          height: screenSize.height / 3,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 15.0, offset: Offset(0, 15))
              ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 0.5)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: ColorConstants.greenAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('Available'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '₹ ${product.price}',
                              style: TextStyle(
                                  color: ColorConstants.redAccent,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.fontSize),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 14,
                                      color: ColorConstants.golden,
                                    ),
                                  ),
                                  TextSpan(
                                      text: ' ${product.rating['rate']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: deleteOnTap,
                    child: const Text('Delete'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
