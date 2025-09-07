import 'package:get/get.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function? onTap;
  final String? image;
  const TitleWidget({super.key, required this.title, this.onTap, this.image});

  @override
  Widget build(BuildContext context) {
    final bool ltr = Get.find<LocalizationController>().isLtr;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        spacing: image != null ? Dimensions.paddingSizeSmall : 0,
        children: [
          image != null ? Image.asset(image!, height: 20, width: 20) : const SizedBox(),
          Text(
            title,
            style: robotoBold.copyWith(fontSize: ResponsiveHelper.isDesktop(context) ? Dimensions.fontSizeLarge : Dimensions.fontSizeLarge),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // image != null ? Image.asset(image!, height: 20, width: 20) : const SizedBox(),
        ],
      ),
      (onTap != null)
          ? InkWell(
              onTap: onTap as void Function()?,
              child: Padding(
                padding: EdgeInsets.fromLTRB(ltr ? 10 : 0, 5, ltr ? 0 : 10, 5),
                child: Row(
                  spacing: 2,
                  children: [
                    Text(
                      'see_all'.tr,
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    ),
                    Icon(Icons.keyboard_arrow_right_sharp, color: Theme.of(context).primaryColor)
                  ],
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
