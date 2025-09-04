import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/features/search/widgets/suggestion_widget.dart';
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
      return FooterView(
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
                          'suggestions'.tr.toUpperCase(),
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
                                return SuggestionWidget(item: searchController.suggestedItemList![index],);
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('no_suggestions_available'.tr))
                      : const SizedBox(),
                ])),
      );
    });
  }
}
