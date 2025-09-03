
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class CouponCardWidget extends StatelessWidget {
  const CouponCardWidget(
      {super.key, required this.discountType, required this.discount});
  final String discountType;
  final double discount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        child: Image.asset(
          Images.couponImg,
          height: 40,
          width: size.width,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
          bottom: 10,
          left: 20,
          child: Column(
            children: [
              Text(
                discountType == 'percent'
                    ? '${discount.toStringAsFixed(0)}%'
                    : PriceConverter.convertPrice(discount),
                style: robotoBold.copyWith(
                    fontSize: 12,
                    color: Get.find<ThemeController>().darkTheme
                        ? Colors.black
                        : Colors.white),
              ),
              Text(
                'off'.tr,
                style: robotoRegular.copyWith(
                    fontSize: 10,
                    color: Get.find<ThemeController>().darkTheme
                        ? Colors.black
                        : Colors.white),
              ),
            ],
          ))
    ]);
  }
}
