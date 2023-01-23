import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteButton extends StatelessWidget {
  final Function onConfirmDelete;
  final dynamic params;
  const DeleteButton(
      {required this.onConfirmDelete, required this.params, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          await onConfirmDelete();
        },
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        icon: const FaIcon(FontAwesomeIcons.trash),
        label: const Text('Delete'));
  }
}

class GreenCheckButton extends StatelessWidget {
  final String label;
  final Function onPress;
  const GreenCheckButton({required this.onPress, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () async {
          await onPress();
        },
        icon: const FaIcon(FontAwesomeIcons.check),
        label: Text(label));
  }
}

class RedCrossedButton extends StatelessWidget {
  final String label;
  final Function onPress;
  const RedCrossedButton({required this.onPress, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        onPressed: () async {
          await onPress();
        },
        icon: const FaIcon(FontAwesomeIcons.xmark),
        label: Text(label));
  }
}
