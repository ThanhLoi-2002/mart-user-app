import 'package:flutter/cupertino.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/search/controllers/search_controller.dart'
    as search;
import 'package:sixam_mart/features/search/widgets/search_app_bar_widget.dart';
import 'package:sixam_mart/features/search/widgets/search_recent_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:sixam_mart/features/search/widgets/filter_widget.dart';
import 'package:sixam_mart/features/search/widgets/search_field_widget.dart';
import 'package:sixam_mart/features/search/widgets/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/store/widgets/bottom_cart_widget.dart';

class SearchScreen extends StatefulWidget {
  final String? queryText;
  const SearchScreen({super.key, required this.queryText});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  final TextEditingController _searchController = TextEditingController();
  late bool _isLoggedIn;

  List<String> _itemsAndStors = <String>[];
  bool _showSuggestion = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _isLoggedIn = AuthHelper.isLoggedIn();
    Get.find<search.SearchController>().setSearchMode(true, canUpdate: false);
    Get.find<search.SearchController>().getPopularCategories();
    if (_isLoggedIn) {
      Get.find<search.SearchController>().getSuggestedItems();
    }
    Get.find<search.SearchController>().getHistoryList();
    if (widget.queryText!.isNotEmpty) {
      _actionSearch(true, widget.queryText, true);
    }
  }

  Future<void> _searchSuggestions(String query) async {
    _itemsAndStors = [];
    if (query == '') {
      _showSuggestion = false;
      _itemsAndStors = [];
    } else {
      _showSuggestion = true;
      _itemsAndStors =
          await Get.find<search.SearchController>().getSearchSuggestions(query);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (Get.find<search.SearchController>().isSearchMode) {
          return;
        } else {
          Get.find<search.SearchController>().setSearchMode(true);
        }
      },
      child: Scaffold(
          appBar:
              ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
          endDrawer: const MenuDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: SafeArea(
              child: Padding(
            padding: ResponsiveHelper.isDesktop(context)
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall,
                    horizontal: Dimensions.paddingSizeDefault),
            child: GetBuilder<search.SearchController>(
                builder: (searchController) {
              if (!GetPlatform.isWeb) {
                _searchController.text = searchController.searchText!;
              }
              return Column(children: [
                // ResponsiveHelper.isDesktop(context)
                //     ? Container(
                //         width: double.infinity,
                //         color: Theme.of(context)
                //             .primaryColor
                //             .withValues(alpha: 0.10),
                //         child: SizedBox(
                //           width: Dimensions.webMaxWidth,
                //           child: Column(
                //             children: [
                //               const SizedBox(
                //                   height: Dimensions.paddingSizeDefault),
                //               Text('search_items_and_stores'.tr,
                //                   style: robotoMedium),
                //               const SizedBox(
                //                   height: Dimensions.paddingSizeDefault),
                //               SizedBox(
                //                   width: Dimensions.webMaxWidth,
                //                   child: GetBuilder<search.SearchController>(
                //                       builder: (searchController) {
                //                     return SearchFieldWidget(
                //                       controller: _searchController,
                //                       radius: 50,
                //                       hint: Get.find<SplashController>()
                //                               .configModel!
                //                               .moduleConfig!
                //                               .module!
                //                               .showRestaurantText!
                //                           ? 'search_food_or_restaurant'.tr
                //                           : 'search_item_or_store'.tr,
                //                       suffixIcon: searchController
                //                               .searchHomeText!.isNotEmpty
                //                           ? Icons.cancel
                //                           : CupertinoIcons.search,
                //                       iconColor:
                //                           Theme.of(context).disabledColor,
                //                       filledColor:
                //                           Theme.of(context).colorScheme.surface,
                //                       onChanged: (text) {
                //                         _searchSuggestions(text);
                //                         searchController.setSearchText(text);
                //                       },
                //                       iconPressed: () {
                //                         if (searchController
                //                             .searchHomeText!.isNotEmpty) {
                //                           _searchController.text = '';
                //                           _showSuggestion = false;
                //                           searchController.setSearchMode(true);
                //                           searchController
                //                               .clearSearchHomeText();
                //                         } else {
                //                           searchData();
                //                         }
                //                       },
                //                       onSubmit: (text) => searchData(),
                //                     );
                //                   })),
                //               const SizedBox(
                //                   height: Dimensions.paddingSizeDefault),
                //               !searchController.isSearchMode
                //                   ? Center(
                //                       child: SizedBox(
                //                           width: Dimensions.webMaxWidth,
                //                           child: Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               Container(
                //                                 width: 200,
                //                                 color: Colors.transparent,
                //                                 child: TabBar(
                //                                   tabAlignment:
                //                                       TabAlignment.start,
                //                                   controller: _tabController,
                //                                   indicatorColor:
                //                                       Theme.of(context)
                //                                           .primaryColor,
                //                                   indicatorWeight: 3,
                //                                   labelColor: Theme.of(context)
                //                                       .primaryColor,
                //                                   unselectedLabelColor:
                //                                       Theme.of(context)
                //                                           .disabledColor,
                //                                   unselectedLabelStyle:
                //                                       robotoRegular.copyWith(
                //                                           color: Theme.of(
                //                                                   context)
                //                                               .disabledColor,
                //                                           fontSize: Dimensions
                //                                               .fontSizeSmall),
                //                                   labelStyle:
                //                                       robotoBold.copyWith(
                //                                           fontSize: Dimensions
                //                                               .fontSizeSmall,
                //                                           color: Theme.of(
                //                                                   context)
                //                                               .primaryColor),
                //                                   labelPadding: const EdgeInsets
                //                                       .symmetric(
                //                                       horizontal: Dimensions
                //                                           .radiusDefault,
                //                                       vertical: 0),
                //                                   isScrollable: true,
                //                                   indicatorSize:
                //                                       TabBarIndicatorSize.tab,
                //                                   tabs: [
                //                                     Tab(text: 'item'.tr),
                //                                     Tab(
                //                                         text: Get.find<
                //                                                     SplashController>()
                //                                                 .configModel!
                //                                                 .moduleConfig!
                //                                                 .module!
                //                                                 .showRestaurantText!
                //                                             ? 'restaurants'.tr
                //                                             : 'stores'.tr),
                //                                   ],
                //                                 ),
                //                               ),
                //                               InkWell(
                //                                   onTap: () {
                //                                     _actionSearch(
                //                                         false,
                //                                         _searchController.text
                //                                             .trim(),
                //                                         false);
                //                                   },
                //                                   child: Image.asset(
                //                                       Images.filter,
                //                                       height: 28,
                //                                       width: 28))
                //                             ],
                //                           )),
                //                     )
                //                   : const SizedBox(),
                //             ],
                //           ),
                //         ),
                //       )
                //     : const SizedBox(),
                widget.queryText!.isNotEmpty
                    ? const SizedBox()
                    : Center(
                        child: ResponsiveHelper.isDesktop(context)
                            ? const SizedBox()
                            : Container(
                                width: Dimensions.webMaxWidth,
                                decoration: BoxDecoration(
                                  color: Get.find<ThemeController>().darkTheme
                                      ? Colors.black12
                                      : Theme.of(context).cardColor,
                                  //boxShadow: Get.find<ThemeController>().darkTheme ? null : [BoxShadow(color: Theme.of(context).disabledColor.withValues(alpha: 0.2), blurRadius: 3, offset: const Offset(0, 5))]
                                ),
                                child: Row(children: [
                                  IconButton(
                                    onPressed: () {
                                      if (searchController.isSearchMode) {
                                        Get.back();
                                      } else {
                                        _showSuggestion = false;
                                        searchController.setSearchMode(true);
                                        searchController.setStore(false);
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_back_sharp),
                                  ),
                                  const Expanded(child: SearchAppBarWidget()),
                                ]))),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Expanded(
                  child: SingleChildScrollView(
                    padding: ResponsiveHelper.isDesktop(context)
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Column(
                    children: [
                      //Search
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).disabledColor,
                              width: 0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SearchFieldWidget(
                          controller: _searchController,
                          radius: 50,
                          filledColor: Theme.of(context)
                              .disabledColor
                              .withValues(alpha: 0.1),
                          hint: 'what_do_you_crave'.tr,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? Icons.clear
                              : null,
                          prefixIcon: CupertinoIcons.search,
                          iconPressed: () {
                            _showSuggestion = false;
                            searchController.setSearchMode(true);
                            searchController.setStore(false);
                            if (GetPlatform.isWeb) {
                              _searchController.text = '';
                            }
                          },
                          onChanged: (text) {
                            searchController.setSearchText(text);
                            _searchSuggestions(text);
                            // _searchController.text = searchController.searchText!;
                          },
                          onSubmit: (text) => _actionSearch(
                              true, _searchController.text.trim(), false),
                        ),
                      ),
                  
                      //Search
                      searchController.isSearchMode
                          ? _showSuggestion
                              ? showSuggestions(
                                  context,
                                  searchController,
                                  _itemsAndStors,
                                )
                              : SearchRecentWidget(
                                  isLoggedIn: _isLoggedIn,
                                  searchController: _searchController,
                                )
                          : SizedBox(
                            height: context.height,
                            child: SearchResultWidget(
                                searchText: _searchController.text.trim(),
                                tabController:
                                    ResponsiveHelper.isDesktop(context)
                                        ? _tabController
                                        : null),
                          ),

                          const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    ],
                  )),
                ),
              ]);
            }),
          )),
          bottomNavigationBar:
              GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.isNotEmpty &&
                    !ResponsiveHelper.isDesktop(context)
                ? const BottomCartWidget()
                : const SizedBox();
          })),
    );
  }

  void searchData() {
    if (_searchController.text.trim().isEmpty) {
      showCustomSnackBar(Get.find<SplashController>()
              .configModel!
              .moduleConfig!
              .module!
              .showRestaurantText!
          ? 'search_food_or_restaurant'.tr
          : 'search_item_or_store'.tr);
    } else {
      _actionSearch(true, _searchController.text, true);
    }
  }

  void _actionSearch(bool isSubmit, String? queryText, bool fromHome) {
    if (Get.find<search.SearchController>().isSearchMode || isSubmit) {
      if (queryText!.isNotEmpty) {
        Get.find<search.SearchController>().searchData(queryText, fromHome);
      } else {
        showCustomSnackBar(Get.find<SplashController>()
                .configModel!
                .moduleConfig!
                .module!
                .showRestaurantText!
            ? 'search_food_or_restaurant'.tr
            : 'search_item_or_store'.tr);
      }
    } else {
      List<double?> prices = [];
      if (!Get.find<search.SearchController>().isStore) {
        for (var product in Get.find<search.SearchController>().allItemList!) {
          prices.add(product.price);
        }
        prices.sort();
      }
      double? maxValue = prices.isNotEmpty ? prices[prices.length - 1] : 1000;
      Get.dialog(FilterWidget(
          maxValue: maxValue,
          isStore: Get.find<search.SearchController>().isStore));
    }
  }

  Widget showSuggestions(
      BuildContext context,
      search.SearchController searchController,
      List<String> foodsAndRestaurants) {
    return FooterView(
      child: SizedBox(
        width: Dimensions.webMaxWidth,
        child: foodsAndRestaurants.isNotEmpty
            ? ListView.builder(
                itemCount: foodsAndRestaurants.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(foodsAndRestaurants[index]),
                    leading: Icon(CupertinoIcons.search,
                        color: Theme.of(context).disabledColor),
                    trailing: Icon(Icons.north_west,
                        color: Theme.of(context).disabledColor),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      _searchController.text = foodsAndRestaurants[index];
                      _actionSearch(true, _searchController.text.trim(), false);
                    },
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.only(top: context.height * 0.2),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomAssetImageWidget(Images.emptyBox,
                          height: 100, width: 100),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      Text('no_suggestions_found'.tr,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).hintColor)),
                    ]),
              ),
      ),
    );
  }
}
