// ignore_for_file: file_names

import 'package:chatapp/widgets/textWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String displayText;
  final Color textColor;
  final double fontSize;
  Color? borderColor;
  Color? backgroundColor;
  VoidCallback? onTap;
  CustomButton({
    super.key,
    this.borderColor,
    this.backgroundColor,
    this.onTap,
    required this.displayText,
    required this.textColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 70, 146, 71),
              width: 3,
            ),
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor,
          ),
          width: double.infinity,
          child: Center(
            child: TextWidget(
                fontFamily: 'Teko',
                data: displayText,
                textColor: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
