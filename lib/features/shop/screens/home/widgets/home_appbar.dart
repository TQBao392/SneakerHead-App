import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:sneakerhead/common/widgets/shimmers/shimmer.dart';
import 'package:sneakerhead/features/personalization/controllers/user_controller.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTittle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.apply(color: TColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              //Display a shimmer loader while user profile is being loaded
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.apply(color: TColors.white),
              );
            }
          }),
        ],
      ),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
          counterBgColor: TColors.black,
          counterTextColor: TColors.white,
        ),
      ],
    );
  }
}
