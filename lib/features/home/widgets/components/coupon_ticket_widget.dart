import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class CouponTicketWidget extends StatelessWidget {
  const CouponTicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 10,
          child: Row(
            children: [
              Image.asset(
                Images.ticketHeader,
              ),
              Container(
                height: 80, // Điều chỉnh chiều rộng theo nhu cầu
                width: 105,
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[200]!, width: 2.0),
                      right: BorderSide(color: Colors.grey[200]!, width: 2.0),
                      bottom: BorderSide(color: Colors.grey[200]!, width: 2.0),
                    ),
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 100,
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(8),
            width: 120,
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giảm giá 20K VNĐ',
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'HSD: 30/09/2025',
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      'Mã: ',
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'PIA2',
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 30,
          top: 25,
          child: Column(
            spacing: 5,
            children: [
              Image.asset(Images.foodCouponIcon),
              const Text(
                'FastFood',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFF7622),
                  fontSize: 10,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Container(
                height: 80,
                width: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radiusDefault), topLeft: Radius.circular(Dimensions.radiusDefault)),
                ))),
        Positioned(
          top: 0,
          left: 0,
          child: Stack(
            children: [
              Image.asset(Images.couponExpiredLabel),
              const Positioned(
                top: 2, // Điều chỉnh vị trí chữ nếu cần
                left: 10, // Điều chỉnh vị trí chữ nếu cần
                child: Text(
                  'Sắp hết hạn',
                  style: TextStyle(
                    color: Colors.white, // Màu chữ
                    fontWeight: FontWeight.normal,
                    fontSize: 10, // Kích thước chữ
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
