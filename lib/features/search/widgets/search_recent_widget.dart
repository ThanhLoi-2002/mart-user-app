import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/search/widgets/coupon_card_widget.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/search/controllers/search_controller.dart'
    as search;

class SearchRecentWidget extends StatefulWidget {
  const SearchRecentWidget(
      {super.key, required this.isLoggedIn, required this.searchController});
  final bool isLoggedIn;
  final TextEditingController searchController;

  @override
  State<SearchRecentWidget> createState() => _SearchRecentWidgetState();
}

class _SearchRecentWidgetState extends State<SearchRecentWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<search.SearchController>(builder: (searchController) {
      return SingleChildScrollView(
        padding: ResponsiveHelper.isDesktop(context)
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
        child: FooterView(
          child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchController.historyList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeSmall),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      ResponsiveHelper.isDesktop(context)
                                          ? 'recent_searches'.tr
                                          : 'your_last_search'.tr,
                                      style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeLarge)),
                                  InkWell(
                                    onTap: () =>
                                        searchController.clearSearchHistory(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimensions.paddingSizeSmall,
                                          horizontal: 4),
                                      child: Text('clear_all'.tr,
                                          style: robotoRegular.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ]),
                          )
                        : const SizedBox(),
                    Wrap(
                        spacing: Dimensions
                            .paddingSizeExtraSmall, // Khoảng cách giữa các thẻ
                        runSpacing: Dimensions
                            .paddingSizeExtraSmall, // Khoảng cách giữa các hàng
                        children: List.generate(
                          searchController.historyList.length > 10
                              ? 10
                              : searchController.historyList.length,
                          (index) => InkWell(
                            onTap: () {
                              widget.searchController.text =
                                  searchController.historyList[index];
                              // searchController.setSearchText(searchController.historyList[index]);
                              searchController.searchData(
                                  searchController.historyList[index], false);
                            },
                            child: Chip(
                              label: Text(
                                searchController.historyList[index],
                                style: robotoRegular,
                              ),
                              deleteIcon: const Icon(Icons.close,
                                  size: 18, color: Colors.black),
                              onDeleted: () =>
                                  searchController.removeHistory(index),
                              backgroundColor:
                                  Colors.grey[50], // Màu nền của thẻ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Đường viền tròn
                                side: const BorderSide(
                                  color: Color.fromRGBO(
                                      153, 153, 153, 1), // Màu viền
                                  width: 1, // Độ dày của viền
                                ),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    (widget.isLoggedIn &&
                            searchController.suggestedItemList != null)
                        ? Text(
                            'suggestions'.tr,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                          )
                        : const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    (widget.isLoggedIn &&
                            searchController.suggestedItemList != null)
                        ? searchController.suggestedItemList!.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.6,
                                  mainAxisSpacing: Dimensions.paddingSizeSmall,
                                  crossAxisSpacing: Dimensions.paddingSizeSmall,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    searchController.suggestedItemList!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusSmall),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .disabledColor
                                                  .withValues(alpha: 0.1),
                                              blurRadius: 10)
                                        ]),
                                    child: CustomInkWell(
                                      onTap: () {
                                        Get.find<ItemController>()
                                            .navigateToItemPage(
                                          searchController
                                              .suggestedItemList![index],
                                          context,
                                        );
                                      },
                                      radius: Dimensions.radiusDefault,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusMedium),
                                                child: CustomImage(
                                                  image:
                                                      '${searchController.suggestedItemList![index].imageFullUrl}',
                                                  width: double.infinity,
                                                  height: 110,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              // Hiển thị thông tin giảm giá
                                              if (searchController
                                                          .suggestedItemList![
                                                              index]
                                                          .discount !=
                                                      null &&
                                                  searchController
                                                          .suggestedItemList![
                                                              index]
                                                          .discount! >
                                                      0)
                                                Positioned(
                                                  bottom: 10,
                                                  left: 20,
                                                  child: Center(
                                                    child: CouponCardWidget(
                                                      discountType:
                                                          searchController
                                                              .suggestedItemList![
                                                                  index]
                                                              .discountType!,
                                                      discount: searchController
                                                          .suggestedItemList![
                                                              index]
                                                          .discount!,
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Text(
                                            searchController
                                                .suggestedItemList![index]
                                                .name!,
                                            style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${searchController.suggestedItemList![index].price!}đ',
                                                style: robotoMedium.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                  color: const Color.fromRGBO(
                                                      77, 77, 77, 1),
                                                ),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .paddingSizeExtraSmall),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star,
                                                      color: Color.fromRGBO(
                                                          255, 214, 10, 1),
                                                      size: 12),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    searchController
                                                        .suggestedItemList![
                                                            index]
                                                        .avgRating!
                                                        .toStringAsFixed(1),
                                                    style:
                                                        robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                      color:
                                                          const Color.fromRGBO(
                                                              77, 77, 77, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('no_suggestions_available'.tr))
                        : const SizedBox(),
                  ])),
        ),
      );
    });
  }
}
