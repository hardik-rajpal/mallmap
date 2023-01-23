import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mallmap/comps/buttons.dart';

confirmAction(
    {required BuildContext context,
    required Function onConfirm,
    Function? onCancel,
    String title = 'Confirm',
    String content = 'Are you sure?'}) {
  showDialog(
      context: context,
      builder: (context) {
        NavigatorState navState = Navigator.of(context);
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () async {
                  await onConfirm();
                  navState.pop();
                },
                icon: const FaIcon(FontAwesomeIcons.check),
                label: const Text('Yes')),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () async {
                  if (onCancel != null) {
                    await onCancel();
                  }
                  navState.pop();
                },
                icon: const FaIcon(FontAwesomeIcons.ban),
                label: const Text('Cancel'))
          ],
        );
      });
}

singleTextFieldDialog(String title, BuildContext context,
    TextEditingController controller, Function onSave,
    {String goLabel = 'Create',
    TextInputType? textInputType = TextInputType.text}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              keyboardType: textInputType,
            ),
            actions: [
              RedCrossedButton(
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  label: 'Cancel'),
              GreenCheckButton(
                  onPress: () async {
                    Navigator.of(context).pop();
                    await onSave();
                  },
                  label: 'Create')
            ],
          ));
}
