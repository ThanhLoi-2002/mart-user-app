import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;
  const NoInternetScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.noInternet, width: 400, height: 400),
          Text("${'oops'.tr} ${'no_internet_connection'.tr}", style: robotoBold.copyWith(
            fontSize: 20,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          )),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            'please_check_your_network_connection'.tr,
            textAlign: TextAlign.center,
            style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
          ),
          const SizedBox(height: 40),
          
          GestureDetector(
            onTap: () async {
              final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
          
              if(!connectivityResult.contains(ConnectivityResult.none)) {
                try {
                  Get.off(child);
                } catch (e) {
                  Get.offAllNamed(RouteHelper.getInitialRoute());
                }
              }
            },
            child: Container(
              width: context.width * 0.3,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                // color: Theme.of(context).primaryColor,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(253, 114, 53, 1), // Màu đầu tiên
                    Color.fromRGBO(255, 159, 20, 1), // Màu thứ hai
                  ],
                  begin: Alignment.topLeft, // Bắt đầu gradient
                  end: Alignment.bottomRight, // Kết thúc gradient
                ),
                borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
              ),
              padding: const EdgeInsets.all(10),
              child: InkWell(
                child: Center(child: Text('retry'.tr, style: robotoMedium.copyWith(
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeLarge,
                ))),
                //Icon(Icons.refresh, size: 34, color: Theme.of(context).cardColor)
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
