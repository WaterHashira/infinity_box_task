import 'package:flutter/material.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/utils/color_constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height / 3,
      width: screenSize.width / 2 - 30,
      child: InkWell(
        child: GestureDetector(
          onTap:
              () {}, //TODO: navigate to product details screen with the curent product passing to it
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 15.0, offset: Offset(0, 15))
              ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.5)
            ),
            child: Column(
              children: <Widget>[
                Expanded(
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
                            color: ColorConstants.greenAccent,
                            child: const Text('Available'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                product.title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline2,
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
                                    TextSpan(
                                        text: ' ${product.rating['count']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '₹ ${product.price}',
                            style: TextStyle(
                                color: ColorConstants.redAccent,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    ?.fontSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
