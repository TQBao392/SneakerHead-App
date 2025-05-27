import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakerhead/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:sneakerhead/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:sneakerhead/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:sneakerhead/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:sneakerhead/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:sneakerhead/utils/constants/image_strings.dart';
import 'package:sneakerhead/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTittle1,
                subTitle: TTexts.onBoardingSubTittle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTittle2,
                subTitle: TTexts.onBoardingSubTittle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTittle3,
                subTitle: TTexts.onBoardingSubTittle3,
              ),
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
