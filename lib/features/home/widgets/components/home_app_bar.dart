import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      bool isSpecificModuleScreen = (splashController.module != null &&
          splashController.configModel!.module == null &&
          splashController.moduleList != null &&
          splashController.moduleList!.length != 1);
      return SliverAppBar(
        floating: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        backgroundColor: ResponsiveHelper.isDesktop(context)
            ? Colors.transparent
            : Theme.of(context).colorScheme.surface,
        title: Center(
            child: Container(
          width: Dimensions.webMaxWidth,
          height: Get.find<LocalizationController>().isLtr ? 60 : 70,
          color: Theme.of(context).colorScheme.surface,
          child: Row(children: [
            // Go back to module list
            isSpecificModuleScreen
                ? InkWell(
                    onTap: () {
                      splashController.removeModule();
                      Get.find<StoreController>().resetStoreData();
                    },
                    child: const Icon(Icons.arrow_back_sharp,
                        size: 20, color: Color(0xFFFF7622)))
                : Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.location_on,
                          size: 15, color: Color(0xFFFF7622)),
                    ),
                  ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
                child: InkWell(
              onTap: () => Get.find<LocationController>()
                  .navigateToLocationScreen('home'),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall,
                  horizontal: ResponsiveHelper.isDesktop(context)
                      ? Dimensions.paddingSizeSmall
                      : 0,
                ),
                child: GetBuilder<LocationController>(
                    builder: (locationController) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AuthHelper.isLoggedIn()
                                  ? AddressHelper
                                          .getUserAddressFromSharedPref()!
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
                                color: Theme.of(context).disabledColor,
                                size: 18),
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
            Container(
              padding: const EdgeInsets.all(
                6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: InkWell(
                child: GetBuilder<NotificationController>(
                    builder: (notificationController) {
                  return Stack(children: [
                    Icon(CupertinoIcons.bell,
                        size: 25,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                    notificationController.hasNotification
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.orange[500],//Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).cardColor),
                              ),
                            ))
                        : const SizedBox(),
                  ]);
                }),
                onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
              ),
            ),
          ]),
        )),
        actions: const [SizedBox()],
      );
    });
  }
}
