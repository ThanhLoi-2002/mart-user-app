import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/search/widgets/suggestion_widget.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/rating_bar.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class SuggestionForYouView extends StatelessWidget {
  const SuggestionForYouView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    Item item = Item(avgRating: 5, discount: 10, discountType: 'amount', name: "Medu Vada", imageFullUrl: "https://tse4.mm.bing.net/th/id/OIP.R1qDxykW4mkur8S9eHZGbwHaE8?pid=Api&P=0&h=220", price: 95);
    return GetBuilder<CouponController>(builder: (couponController) {
      List<CouponModel>? couponList = couponController.mockupCouponList;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: TitleWidget(
              title: title,
              onTap: () => {},
            ),
          ),
          SizedBox(
            height: 160,
            child: couponList != null
                ? ListView.builder(
                    controller: ScrollController(),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                    itemCount: 5, //couponList.length > 10 ? 10 : couponList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, bottom: 5),
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.15), blurRadius: 7, spreadRadius: 0)],
                          ),
                          child: CustomInkWell(
                              onTap: () {
                                // if (isFeatured && Get.find<SplashController>().moduleList != null) {
                                //   for (ModuleModel module in Get.find<SplashController>().moduleList!) {
                                //     if (module.id == couponList[index].moduleId) {
                                //       Get.find<SplashController>().setModule(module);
                                //       break;
                                //     }
                                //   }
                                // }
                                // Get.toNamed(
                                //   RouteHelper.getStoreRoute(id: couponList[index].id, page: isFeatured ? 'module' : 'store'),
                                //   arguments: StoreScreen(store: couponList[index], fromModule: isFeatured),
                                // );
                              },
                              radius: Dimensions.radiusSmall,
                              child: SuggestionWidget(item: item)),
                        ),
                      );
                    },
                  )
                : const SuperCouponShimmer(),
          ),
        ],
      );
    });
  }
}

class SuperCouponShimmer extends StatelessWidget {
  const SuperCouponShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 150,
          width: 200,
          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: 5),
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radiusSmall), boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)]),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 90,
                width: 200,
                decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall)), color: Colors.grey[300]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 10, width: 100, color: Colors.grey[300]),
                    const SizedBox(height: 5),
                    Container(height: 10, width: 130, color: Colors.grey[300]),
                    const SizedBox(height: 5),
                    const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                  ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
