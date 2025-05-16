import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/common/widgets/login_signup/form_divider.dart';
import 'package:sneakerhead/common/widgets/login_signup/social_buttons.dart';
import 'package:sneakerhead/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/constants/text_strings.dart';
import 'package:sneakerhead/utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Form
              const TSignupForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Divider
              TFormDivider(dividerText: TTexts.orSignUpwith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Social Button
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
