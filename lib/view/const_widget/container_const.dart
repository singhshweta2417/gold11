
import 'package:flutter/material.dart';

import '../../res/sizes_const.dart';

class ContainerConst extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Color? color;
  final Gradient?gradient;
  final void Function()? onTap;
  final DecorationImage? image;
  final Widget? child;
  final Alignment? alignment;
  final List<BoxShadow>? boxShadow;
  final BoxShape? shape;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? minHeight;
  const ContainerConst({super.key,  this.width, this.height, this.border, this.borderRadius, this.color, this.gradient, this.onTap, this.image, this.child, this.alignment, this.boxShadow, this.shape, this.padding, this.margin, this.minHeight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,width: width,
        alignment: alignment,
        decoration: BoxDecoration(
          boxShadow:boxShadow,
          color: color??Colors.transparent,
          border: border,
          borderRadius:borderRadius,
          gradient: gradient,
          image: image,
          shape: shape?? BoxShape.rectangle
        ),
        constraints: BoxConstraints(
          maxWidth: Sizes.screenWidth,
          minHeight: minHeight??0.0
        ),
        child: child,
      ),
    );
  }
}
