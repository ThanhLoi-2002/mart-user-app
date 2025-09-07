import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';
import 'package:sixam_mart/features/home/widgets/components/module_card_widget.dart';
import 'package:sixam_mart/features/home/widgets/module_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/home/widgets/suggestion_for_you_view.dart';
import 'package:sixam_mart/features/home/widgets/super_coupon_view.dart';
import 'package:sixam_mart/features/home/widgets/super_deal_view.dart';
import 'package:sixam_mart/features/home/widgets/travel_with_view.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/images.dart';

class ModuleView extends StatelessWidget {
  final SplashController splashController;
  const ModuleView({super.key, required this.splashController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        splashController.moduleList != null
            ? splashController.moduleList!.isNotEmpty
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: Dimensions.paddingSizeSmall,
                      crossAxisSpacing: 0,
                      childAspectRatio: (1 / 1),
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    itemCount: splashController.moduleList!.length > 8 ? 8 : splashController.moduleList!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 7 && splashController.moduleList!.length > 8) {
                        return ModuleCardWidget(
                          ontap: () => _displayAllModulesFunctionality(),
                          imageUrl: Images.allIcon,
                          title: "all".tr,
                          isLocalImg: true,
                        );
                      } else {
                        return ModuleCardWidget(
                          ontap: () => splashController.switchModule(index, true),
                          imageUrl: '${splashController.moduleList![index].iconFullUrl}',
                          title: '${splashController.moduleList![index].moduleName}',
                        );
                      }
                    },
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Text('no_module_found'.tr),
                  ))
            : ModuleShimmer(isEnabled: splashController.moduleList == null),
        const SuperCouponView(),
        // const SuperDealView(),
        SuggestionForYouView(title: 'super_deal'.tr.toUpperCase()),
        SuggestionForYouView(title: 'suggestions_for_you'.tr.toUpperCase()),
        GetBuilder<BannerController>(builder: (bannerController) {
          return const BannerView(isFeatured: true);
        }),
        SuggestionForYouView(title: 'delicious_food_near_you'.tr.toUpperCase()),

        // vi vu
        const TravelWithView(),
        SuggestionForYouView(title: 'favorite_restaurant'.tr.toUpperCase()),
        const SizedBox(height: 120),
      ]),
    );
  }

  _displayAllModulesFunctionality() {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const ModuleBottomSheetWidget(),
        );
      },
    );
  }
}

class ModuleShimmer extends StatelessWidget {
  final bool isEnabled;
  const ModuleShimmer({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: 0, childAspectRatio: (1 / 1)),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Shimmer(
              duration: const Duration(seconds: 2),
              enabled: isEnabled,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Center(child: Container(height: 15, width: 40, color: Colors.grey[200])),
              ]),
            ),
          ],
        );
      },
    );
  }
}

class AddressShimmer extends StatelessWidget {
  final bool isEnabled;
  const AddressShimmer({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimensions.paddingSizeLarge),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: TitleWidget(title: 'deliver_to'.tr),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        SizedBox(
          height: 70,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                child: Container(
                  padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.location_on,
                      size: ResponsiveHelper.isDesktop(context) ? 50 : 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Shimmer(
                        duration: const Duration(seconds: 2),
                        enabled: isEnabled,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(height: 15, width: 100, color: Colors.grey[300]),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          Container(height: 10, width: 150, color: Colors.grey[300]),
                        ]),
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
