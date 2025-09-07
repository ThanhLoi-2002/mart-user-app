import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/rating_bar.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class SuperDealView extends StatelessWidget {
  const SuperDealView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(builder: (couponController) {
      List<CouponModel>? couponList = couponController.mockupCouponList;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: TitleWidget(
              title: 'super_deal'.tr.toUpperCase(),
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
                    itemCount: couponList.length > 10 ? 10 : couponList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, bottom: 5),
                        child: Container(
                          width: 200,
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
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              Stack(children: [
                                const ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall)),
                                  child: CustomImage(
                                    image: '',
                                    height: 90,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const DiscountTag(discount: 10, discountType: 'amount', freeDelivery: true),
                                Positioned(
                                  top: Dimensions.paddingSizeExtraSmall,
                                  right: Dimensions.paddingSizeExtraSmall,
                                  child: GetBuilder<FavouriteController>(builder: (favouriteController) {
                                    bool isWished = favouriteController.wishStoreIdList.contains(couponList[index].id);
                                    return InkWell(
                                      onTap: () {
                                        if (AuthHelper.isLoggedIn()) {
                                          isWished ? favouriteController.removeFromFavouriteList(couponList[index].id, true) : favouriteController.addToFavouriteList(null, couponList[index].id, true);
                                        } else {
                                          showCustomSnackBar('you_are_not_logged_in'.tr);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        ),
                                        child: Icon(
                                          isWished ? Icons.favorite : Icons.favorite_border,
                                          size: 15,
                                          color: isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ]),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(
                                      couponList[index].title ?? '',
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                    Text(
                                      'address',
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                  ]),
                                ),
                              ),
                            ]),
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
