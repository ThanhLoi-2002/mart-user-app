import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';

class SearchAppBarWidget extends StatefulWidget {
  const SearchAppBarWidget({super.key});

  @override
  State<SearchAppBarWidget> createState() => _SearchAppBarWidgetState();
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Container(
        width: Dimensions.webMaxWidth,
        height: Get.find<LocalizationController>().isLtr ? 60 : 70,
        color: Theme.of(context).colorScheme.surface,
        child: Row(children: [
          Expanded(
              child: InkWell(
            onTap: () =>
                Get.find<LocationController>().navigateToLocationScreen('home'),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeSmall,
                horizontal: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.paddingSizeSmall
                    : 0,
              ),
              child:
                  GetBuilder<LocationController>(builder: (locationController) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            AuthHelper.isLoggedIn()
                                ? AddressHelper.getUserAddressFromSharedPref()!
                                    .addressType!
                                    .tr
                                : 'your_location'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: Dimensions.fontSizeDefault),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(Icons.expand_more,
                              color: Theme.of(context).disabledColor, size: 18),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          AddressHelper.getUserAddressFromSharedPref()!
                              .address!,
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: Dimensions.fontSizeSmall),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]);
              }),
            ),
          )),
          const SizedBox(width: Dimensions.paddingSizeLarge),
        ]),
      );
    });
  }
}
