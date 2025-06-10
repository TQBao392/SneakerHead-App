// ignore_for_file: unused_import

import 'dart:developer'; // For Logcat logging

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sneakerhead/common/widgets/shimmers/shimmer.dart';
import 'package:sneakerhead/utils/constants/colors.dart';
import 'package:sneakerhead/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.border,
    this.padding,
    this.applyImageRadius = true,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final borderRad = applyImageRadius
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.zero;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          border: border ?? Border.all(color: Colors.blueAccent), // Debug border
          borderRadius: borderRad,
        ),
        child: ClipRRect(
          borderRadius: borderRad,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            placeholder: (context, url) {
              return TShimmerEffect(
                width: width ?? double.infinity,
                height: height ?? 158,
              );
            },
            errorWidget: (context, url, error) {
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
        ),
      ),
    );
  }
}
