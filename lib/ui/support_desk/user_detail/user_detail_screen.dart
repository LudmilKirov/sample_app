import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:support_desk/data/services/users/model/user_model.dart';
import 'package:support_desk/res/colors.dart';
import 'package:support_desk/res/dimensions.dart';
import 'package:support_desk/res/images/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_desk/res/strings/str_keys.dart';
import 'package:support_desk/res/styles.dart';
import 'package:support_desk/ui/support_desk/user_detail/user_details_controller.dart';
import 'package:support_desk/utils/app_util.dart';

class UserDetailsPage extends GetView<UserDetailsController> {
  final User user;

  UserDetailsPage({required this.user}) {
    controller.init(user);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          controller.onFinish();
          return false;
        },
        child: Scaffold(
          body: _buildBody(),
          appBar: _buildAppBar(),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: SupportDeskColors.accentColor,
      shadowColor: Colors.transparent,
      leading: _backImage(),
      title: Text(StrKey.backLabel.tr),
    );
  }

  Widget _backImage() {
    return GestureDetector(
      onTap: () {
        controller.onFinish();
      },
      child: SvgPicture.asset(
        Img.icBack,
        width: _backButtonWidth,
        height: _backButtonHeight,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildBody() {
    String phone = '${StrKey.phoneLabel.tr} ${user.phone}';

    return Center(
      child: SizedBox(
        width: _columnWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SupportDeskMargins.large.toSpace(),
            _mainImageAndAvailabilityImage(),
            SupportDeskMargins.large.toSpace(),
            _buildName(),
            SupportDeskMargins.small.toSpace(),
            _buildEmailAndPhoneText(phone),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(AppUtil.getNameToShowForTheUser(user), style: Style.boldNameStyle);
  }

  Widget _buildEmailAndPhoneText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: _emailAndNumberFontSize, color: SupportDeskColors.grey),
    );
  }

  Widget _mainImageAndAvailabilityImage() {
    return Stack(
      children: [
        AppUtil.buildMainImage(user.image ?? ''),
        Positioned(
          bottom: _bottomAvailabilityPosition,
          right: _rightAvailabilityPosition,
          child: _availabilityImage(),
        )
      ],
    );
  }

  Widget _availabilityImage() {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.changeAvailability();
        },
        child: SvgPicture.asset(
          controller.availability.value ? Img.icAvailable : Img.icBusy,
          height: _availabilityImageHeight,
          width: _availabilityImageWidth,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

const double _availabilityImageHeight = 45.0;
const double _availabilityImageWidth = 45.0;
const double _bottomAvailabilityPosition = 2.0;
const double _rightAvailabilityPosition = 2.0;
final double _columnWidth = Get.width * 0.85;
const double _emailAndNumberFontSize = 16.0;
const double _backButtonWidth = 24.0;
const double _backButtonHeight = 24.0;
