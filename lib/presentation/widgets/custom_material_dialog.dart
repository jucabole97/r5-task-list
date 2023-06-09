import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CustomMaterialDialog {

  static Future<void> showMaterialDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String confimButtonText,
    required Function onTapConfirmButton,
    bool isEnableCancelButton = true,
    String? cancelButtonText,
    Function? onTapCancelButton,
  }) {
    return Dialogs.materialDialog(
      msg: description,
      title: title,
      color: Colors.white,
      context: context,
      actions: [
        Visibility(
          visible: isEnableCancelButton,
          child: IconsOutlineButton(
            onPressed: () {
              if (onTapCancelButton != null) {
                onTapCancelButton.call();
              } else {
                Navigator.pop(context);
              }
            },
            text: cancelButtonText ?? 'Cancelar',
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
        ),
        IconsButton(
          onPressed: () {
            onTapConfirmButton.call();
            Navigator.pop(context);
          },
          text: confimButtonText,
          iconData: Icons.delete,
          color: Colors.red,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
  
}