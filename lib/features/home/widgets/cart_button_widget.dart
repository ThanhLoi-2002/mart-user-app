import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/images.dart';

class CartButtonWidget extends StatefulWidget {
  const CartButtonWidget({super.key});

  @override
  State<CartButtonWidget> createState() => _CartButtonWidgetState();
}

class _CartButtonWidgetState extends State<CartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.toNamed(RouteHelper.cart),
        child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[800]!, width: 0.5),
            color: Colors.grey[50],
          ),
          child: Stack(children: [
            Image.asset(Images.bagIcon, color: Colors.black),
            Positioned(
                top: 1,
                right: 4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                ))
          ]),
        ));
  }
}