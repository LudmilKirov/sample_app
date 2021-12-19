import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:support_desk/data/services/users/model/user_model.dart';
import 'package:support_desk/res/colors.dart';
import 'package:support_desk/res/dimensions.dart';
import 'package:support_desk/res/images/images.dart';
import 'package:support_desk/res/strings/str_keys.dart';
import 'package:support_desk/res/styles.dart';
import 'package:support_desk/ui/support_desk/support_desk_list_view_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_desk/ui/support_desk/user_detail/user_detail_screen.dart';
import 'package:support_desk/utils/app_util.dart';
import 'package:support_desk/utils/ui_utils.dart';

class SupportDeskScreen extends GetView<SupportDeskController> {
  const SupportDeskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: _buildBody(),
        appBar: _buildAppBar(),
      ),
    );
  }

  Widget _buildBody() {
    return _buildListViewUsers();
  }

  Widget _buildListViewUsers() {
    return Obx(() => controller.usersForUi.isNotEmpty
        ? ListView.builder(
            itemCount: controller.usersForUi.length,
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              return _buildUsersColumn(index);
            },
          )
        : Center(child: Text(StrKey.noUsersMatchedTheCriteriaLabel.tr)));
  }

  Widget _buildUsersColumn(int index) {
    return GestureDetector(
      onTap: () async {
        await _goToDetailsPage(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SupportDeskMargins.large.toSpace(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(SupportDeskMargins.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _mainImageAndAvailabilityImage(index),
                  SupportDeskMargins.medium.toSpace(),
                  _buildName(index),
                  SupportDeskMargins.small.toSpace(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToDetailsPage(int index) async {
    User updatedUser = await Get.to(() => UserDetailsPage(
          user: controller.usersForUi[index],
        ));
    controller.updateUsers(updatedUser);
  }

  Widget _buildName(int index) =>
      Text(AppUtil.getNameToShowForTheUser(controller.usersForUi[index]), style: Style.boldNameStyle);

  Widget _mainImageAndAvailabilityImage(int index) {
    return Stack(
      children: [
        AppUtil.buildMainImage(controller.usersForUi[index].image ?? ''),
        Positioned(
          bottom: _bottomAvailabilityPosition,
          right: _rightAvailabilityPosition,
          child: _availabilityImage(index),
        )
      ],
    );
  }

  Widget _availabilityImage(int index) {
    return SvgPicture.asset(
      controller.usersForUi[index].available ? Img.icAvailable : Img.icBusy,
      height: _availabilityImageHeight,
      width: _availabilityImageWidth,
      fit: BoxFit.fill,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: SupportDeskColors.accentColor,
      shadowColor: Colors.transparent,
      toolbarHeight: _appBarHeight,
      title: Obx(
        () => controller.isSearchTapped.value
            ? _buildTextField()
            : Padding(
                padding: const EdgeInsets.only(left: SupportDeskMargins.medium, right: SupportDeskMargins.medium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildTitleAndSearchIcon(),
                ),
              ),
      ),
    );
  }

  List<Widget> _buildTitleAndSearchIcon() {
    return [
      Text(StrKey.supportDeskTitle.tr),
      const Spacer(),
      _buildSearchImage(),
    ];
  }

  Widget _buildSearchImage() {
    return GestureDetector(
      onTap: () {
        controller.isSearchTapped.toggle();
      },
      child: SvgPicture.asset(
        Img.icSearch,
        color: SupportDeskColors.white,
        height: _searchImageHeight,
        width: _searchImageWidth,
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      alignment: Alignment.centerLeft,
      color: SupportDeskColors.white,
      child: SizedBox(
        child: TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          controller: controller.searchController,
          decoration: UiUtils.etInputDecoration(hint: StrKey.searchHint.tr),
          onFieldSubmitted: (text) {
            controller.search(text);
          },
        ),
      ),
    );
  }
}

const double _appBarHeight = 80.0;
const double _searchImageHeight = 20.0;
const double _searchImageWidth = 20.0;
const double _availabilityImageHeight = 35.0;
const double _availabilityImageWidth = 35.0;
const double _bottomAvailabilityPosition = 2.0;
const double _rightAvailabilityPosition = 2.0;
