import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/search/widgets/ticket_widget.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                blurRadius: 10)
          ]),
      child: CustomInkWell(
        onTap: () {
          Get.find<ItemController>().navigateToItemPage(
            item,
            context,
          );
        },
        radius: Dimensions.radiusDefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
                  child: CustomImage(
                    image: '${item.imageFullUrl}',
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                // Hiển thị thông tin giảm giá
                if (item.discount != null && item.discount! > 0)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: TicketWidget(
                      discountType: item.discountType!,
                      discount: item.discount!,
                    ),
                  )
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              item.name!,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  PriceConverter.convertPrice(item.price!),
                  style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: const Color.fromRGBO(77, 77, 77, 1),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Row(
                  children: [
                    const Icon(Icons.star,
                        color: Color.fromRGBO(255, 214, 10, 1), size: 12),
                    const SizedBox(width: 2),
                    Text(
                      item.avgRating!.toStringAsFixed(1),
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: const Color.fromRGBO(77, 77, 77, 1),
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
  }
}
