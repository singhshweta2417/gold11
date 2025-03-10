// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/sizes_const.dart';


class ButtonConst extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? label;
  final TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final double? space;
  final double? iconSize;
  final List<BoxShadow>? boxShadow;
  bool? isClicked;
  final BoxShape? shape;
  final bool? inCol;
  final BoxBorder? border;
  ButtonConst(
      {this.alignment,
      this.padding,
      this.color,
      this.decoration,
      this.width,
      this.height,
      this.margin,
      this.gradientColorOne,
      this.gradientColorTwo,
      this.shadowColor,
      this.dx,
      this.dy,
      this.gradient,
      this.label,
      this.style,
      this.icon,
      this.fontWeight,
      this.fontStyle,
      this.iconColor,
      this.textColor=Colors.black,
      this.fontSize,
      this.begin,
      this.end,
      this.blurRadius,
      this.spreadRadius,
      this.child,
      this.borderRadius,
      this.onTap,
      this.space,
      this.iconSize,
      this.boxShadow,
      this.isClicked,
      this.shape,
      this.inCol=false,
      this.border});

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        padding: padding,
        height: height ?? 42,
        width: width ?? widths,
        decoration: BoxDecoration(
            shape: shape == null ? BoxShape.rectangle : shape!,
            borderRadius: borderRadius ?? BorderRadius.circular(4),
            color: color ?? Colors.grey.shade100,
            gradient: gradient,
            boxShadow: boxShadow,
            border: border),
        child: child ??
            (icon == null
                ? Text(
                    label == null ? "" : label!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: fontSize ?? Sizes.fontSizeTwo,
                            color: textColor ?? Colors.white,
                            fontWeight: fontWeight ?? FontWeight.w500)),
                    textAlign: TextAlign.center,
                  )
                : inCol == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            color: iconColor ?? Colors.white,
                            size: iconSize,
                          ),
                          SizedBox(
                            width: space ?? 5,
                          ),
                          Text(
                            label == null ? "" : label!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize:fontSize?? Sizes.fontSizeTwo,
                                    color: textColor ?? Colors.white,
                                    fontWeight: fontWeight ?? FontWeight.w500)),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: iconColor ?? Colors.white,
                            size: iconSize,
                          ),
                          SizedBox(
                            width: space ?? 5,
                          ),
                          Text(
                            label == null ? "" : label!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: textColor ?? Colors.white,
                                    fontSize: fontSize ?? Sizes.fontSizeTwo,
                                    fontWeight: fontWeight ?? FontWeight.w500)),
                          ),
                        ],
                      )),
      ),
    );
  }
}
