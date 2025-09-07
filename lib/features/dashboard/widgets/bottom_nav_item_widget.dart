import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class BottomNavItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  const BottomNavItemWidget({super.key, this.onTap, this.isSelected = false, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

          Image.asset(
            icon, height: 25, width: 25,
            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!,
          ),

          SizedBox(height: isSelected ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall),

          Text(
            title,
            style: robotoRegular.copyWith(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!, fontSize: 12),
          ),

        ]),
      ),
    );
  }
}
