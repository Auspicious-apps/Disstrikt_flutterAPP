/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */



import 'package:disstrikt/app/export.dart';

logoutDialog() {
  return Get.dialog(
    Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white10,
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin_40),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: width_4),
            borderRadius: BorderRadius.circular(margin_10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: AppColors.appColor),
                  child: Icon(
                    Icons.close,
                    size: height_15,
                    color: Colors.white,
                  ).paddingAll(margin_5),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 4)],
                  border: Border.all(color: Colors.white, width: width_4),
                  borderRadius: BorderRadius.circular(margin_10)),
              child: Column(
                children: [
                  AssetImageWidget(iconsSplashLogo, imageHeight: height_70)
                      .marginOnly(bottom: height_10),
                  TextView(
                    text:  "Logout",
                    textStyle: textStyleBodyMedium(),
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ).marginOnly(bottom: height_10),
                  Row(
                    children: [
                      Expanded(
                          child: _yesBtn(
                                  onTap: () {

                                  },
                                  label: 'Logout')
                              .marginOnly(right: width_10)),
                      Expanded(child: _noBtn().marginOnly(left: width_10)),
                    ],
                  ).paddingOnly(top: margin_10),
                ],
              ),
            ),
          ],
        ).marginAll(margin_5),
      ),
    ),
    barrierDismissible: false,
  );
}




Widget _yesBtn({onTap, label}) {
  return MaterialButtonWidget(

    onPressed: onTap ?? () {},
    buttonText: label ?? '',
  );
}

Widget _noBtn() {
  return MaterialButtonWidget(

    onPressed: () {
      Get.back();
    },
    buttonText: 'Cancel',
  );
}

appExpirationDialog() {
  return Get.dialog(
    AlertDialog(
      title: Container(
          height: height_150,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_10),
                topRight: Radius.circular(radius_10),
              )),
          child: const AssetImageWidget(iconsSplashLogo, imageFitType: BoxFit.cover)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: margin_10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView( text: "Demo Expired",
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    textStyle: textStyleBodyMedium())
                .marginOnly(bottom: height_10),
            TextView( text: "Demo Desc",
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    textStyle: textStyleBodyMedium())
                .marginOnly(bottom: height_10),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_10)),
    ),
    barrierColor: Colors.grey.shade300,
    barrierDismissible: false,
  );
}

commonDialog(contentWidget, {titleWidget, leading, barrierDismiss}) {
  return Get.dialog(
    AlertDialog(
      title: Container(
          child: Column(children: [
        leading ??
            Container(
                margin: EdgeInsets.only(right: margin_10, top: margin_10),
                alignment: Alignment.topRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(height_100),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.grey,
                      )),
                )),
        titleWidget ??
            Container(
                height: height_100,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius_10),
                      topRight: Radius.circular(radius_10),
                    )),
                child: const AssetImageWidget(iconsSplashLogo, imageFitType: BoxFit.cover))
      ])),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: contentWidget ?? Container(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_20)),
    ),
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: barrierDismiss ?? false,
  );
}
