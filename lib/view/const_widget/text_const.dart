import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/sizes_const.dart';

class TextConst extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final double? width;
  final FontStyle? style;
  final double? height;
  final void Function()? onTap;
  const TextConst(
      {super.key,
      required this.text,
      this.fontWeight,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.padding,
      this.alignment,
      this.width,
      this.style,
      this.height,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: alignment ?? Alignment.center,
        padding: padding,
        child: Text(text,
            overflow: overflow,
            softWrap: softWrap,
            textAlign: textAlign,
            maxLines: maxLines,
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                height: height,
                fontSize: fontSize ?? Sizes.fontSizeTwo,
                fontWeight: fontWeight ?? FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: textColor ?? Colors.black,
              ),
            )),
      ),
    );
  }
}
