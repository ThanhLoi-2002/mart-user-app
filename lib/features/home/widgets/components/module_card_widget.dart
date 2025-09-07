import 'package:flutter/material.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class ModuleCardWidget extends StatelessWidget {
  const ModuleCardWidget({super.key, required this.ontap, required this.imageUrl, required this.title, this.isLocalImg});
  final Function() ontap;
  final String imageUrl;
  final String title;
  final bool? isLocalImg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInkWell(
          radius: 50,
          onTap: ontap,
          child: SizedBox(
            width: 70,
            height: 70,
            // decoration: BoxDecoration(color: Colors.red),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Images.moduleBackgroundOutSide,
                ),
                Image.asset(
                  Images.moduleBackgroundInSide,
                ),
                ClipRRect(
                  child: isLocalImg == true
                      ? Image.asset(
                          imageUrl,
                          height: 35,
                          width: 35,
                        )
                      : CustomImage(
                          image: imageUrl,
                          height: 35,
                          width: 35,
                        ),
                ),
              ],
            ),
          ),
        ),
        Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
        )),
      ],
    );
  }
}
