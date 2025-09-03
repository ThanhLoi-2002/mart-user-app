import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/features/home/screens/home_screen.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, required this.searchBgShow, required this.isTaxi});

  final bool searchBgShow;
  final bool isTaxi;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverDelegate(
          callback: (val) {},
          child: Center(
              child: Container(
            height: 50,
            width: context.width * 0.9,
            color: searchBgShow
                ? Get.find<ThemeController>().darkTheme
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).cardColor
                : null,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: isTaxi
                ? Container(color: Theme.of(context).primaryColor)
                : InkWell(
                    onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Colors.grey[50]!,//Theme.of(context)
                                // .primaryColor
                                // .withValues(alpha: 0.2),
                            width: 1),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              spreadRadius: 1)
                        ],
                      ),
                      child: Row(children: [

                        Icon(
                          CupertinoIcons.search,
                          size: 25,
                          color: Colors.grey[800],//Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Expanded(
                            child: Text(
                          Get.find<SplashController>()
                                  .configModel!
                                  .moduleConfig!
                                  .module!
                                  .showRestaurantText!
                              ? 'search_food_or_restaurant'.tr
                              : 'search_item_or_store'.tr,
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor,
                          ),
                        )),
                      ]),
                    ),
                  ),
          ))),
    );
  }
}