import 'package:flutter/material.dart';
import 'package:r5_task_list/core/framework/text_utils.dart';

class CustomFormSection extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool readOnly;
  final Function? onTap;
  final Icon? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomFormSection({
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
        ),
        validator: (String? value) {
          if (keyboardType == TextInputType.emailAddress) {
            return 'Digite al menos ocho caracteres';
          } else if (value != null && value.length < 8) {
            final bool isValid = TextUtils.isValidEmail(value);
            if (!isValid) {
              return '¡Digite un formato para correo válido!';
            }
          }
          return '';
        },
        readOnly: readOnly,
        onTap: () {
          if (onTap != null) {
            onTap!.call();
          }
        },
        obscureText: obscureText,
      ),
    );
  }
}