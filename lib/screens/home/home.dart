import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sneakerhead/common/widgets/appbar/appbar.dart';
import 'package:sneakerhead/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TTexts.homeAppbarTittle,
                          style: Theme.of(context).textTheme.labelMedium?.apply(color: TColors.grey),
                        ),
                        Text(
                          TTexts.homeAppbarSubTittle,
                          style: Theme.of(context).textTheme.headlineSmall?.apply(color: TColors.white),
                        ),
                      ],
                    ),
                    actions: [
                      TCartCounterIcon(onPressed: (){}, iconColor: TColors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed, required this.IconColor,
  });

  final Color IconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag, color: iconColor)
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge?.apply(color: TColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}