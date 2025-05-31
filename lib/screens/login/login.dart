import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sneakerhead/common/styles/spacing_styles.dart';
import 'package:sneakerhead/common/widgets/login_signup/form_divider.dart';
import 'package:sneakerhead/common/widgets/login_signup/social_buttons.dart';
import 'package:sneakerhead/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sneakerhead/features/authentication/screens/login/widgets/login_header.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';
import 'package:sneakerhead/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, Tittle & Sub-Title
              const TLoginHeader(),

              /// Form
              const TLoginForm(),

              /// Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
