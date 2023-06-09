import 'package:flutter/material.dart';
import 'package:r5_task_list/core/framework/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onTapButton;

  const CustomButton({
    required this.buttonText,
    required this.onTapButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: const BorderSide(
            width: 2,
            color: primaryColor,
          ),
        ),
        onPressed: () => onTapButton.call(),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}