import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/features/home/widgets/components/coupon_ticket_widget.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/common/widgets/rating_bar.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class SuperCouponView extends StatelessWidget {
  const SuperCouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(builder: (couponController) {
      List<CouponModel>? couponList = couponController.mockupCouponList;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: TitleWidget(
              title: 'super_coupon'.tr.toUpperCase(),
              image: Images.superCoupon,
              onTap: () => {},
            ),
          ),
          SizedBox(
            height: 110,
            child: couponList != null
                ? ListView.builder(
                    controller: ScrollController(),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                    itemCount: couponList.length > 10 ? 10 : couponList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, bottom: 5),
                        child: SizedBox(
                          width: 230,
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
                            child: const CouponTicketWidget()
                               
                          ),
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
