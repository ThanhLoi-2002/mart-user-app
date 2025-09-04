import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget(
      {super.key, required this.discountType, required this.discount});
  final String discountType;
  final double discount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(Images.couponImg, fit: BoxFit.cover, width: size.width * 0.22),
        SizedBox(
          width: size.width * 0.2,
          height: 39,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'off'.tr,
                style: robotoRegular.copyWith(
                  fontSize: 8,
                  color: Get.find<ThemeController>().darkTheme
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              Text(
                discountType == 'percent'
                    ? '${discount.toStringAsFixed(0)}%'
                    : PriceConverter.convertPrice(discount),
                style: robotoBold.copyWith(
                  fontSize: 10,
                  color: Get.find<ThemeController>().darkTheme
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
