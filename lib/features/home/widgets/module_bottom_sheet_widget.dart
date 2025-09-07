import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/home/widgets/components/module_card_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class ModuleBottomSheetWidget extends StatelessWidget {
  const ModuleBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Container(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 5,
              width: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            Center(child: Text('all_modules'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge))),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('food_and_shopping'.tr, style: robotoBold),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: Dimensions.paddingSizeSmall,
                crossAxisSpacing: 0,
                childAspectRatio: (1 / 1),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              itemCount: splashController.foodModuleList!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ModuleCardWidget(
                  ontap: () {
                    splashController.switchFoodModule(index, true);
                    Get.back();
                  },
                  imageUrl: '${splashController.foodModuleList![index].iconFullUrl}',
                  title: '${splashController.foodModuleList![index].moduleName}',
                );
              },
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('ride_and_delivery'.tr, style: robotoBold),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: Dimensions.paddingSizeSmall,
                crossAxisSpacing: 0,
                childAspectRatio: (1 / 1),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              itemCount: splashController.deliveryModuleList!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ModuleCardWidget(
                  ontap:  () {
                    splashController.switchDeliveryModule(index, true);
                    Get.back();
                  },
                  imageUrl: '${splashController.deliveryModuleList![index].iconFullUrl}',
                  title: '${splashController.deliveryModuleList![index].moduleName}',
                );
              },
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
          ]),
        ),
      );
    });
  }
}
