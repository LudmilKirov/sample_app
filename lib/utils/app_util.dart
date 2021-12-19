import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:support_desk/data/services/users/model/user_model.dart';
import 'package:support_desk/res/images/images.dart';
import 'package:support_desk/res/strings/str_keys.dart';

class AppUtil {
  static Widget buildMainImage(String image) {
    return image.isEmpty
        ? _offlineImage()
        : CachedNetworkImage(
            imageUrl: image,
            height: _imageHeight,
            width: _imageWidth,
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(child: Text(StrKey.loadingImageLabel.tr)),
            errorWidget: (context, url, error) => _offlineImage(),
          );
  }

  static Image _offlineImage() {
    return Image.asset(
      Img.imgNotAvailable,
      height: _imageHeight,
      width: _imageWidth,
      fit: BoxFit.fill,
    );
  }

  static String getNameToShowForTheUser(User user) {
    return user.firstName + ' ' + user.lastName;
  }
}


final double _imageHeight = Get.height * 0.33;
final double _imageWidth = Get.width * 0.85;
