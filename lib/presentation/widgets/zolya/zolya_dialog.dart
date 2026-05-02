import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ZolyaDialog extends StatelessWidget {
  const ZolyaDialog({
    super.key,
    this.title,
    this.description,
    required this.body,
    this.actions = const [],
    this.alert = false,
  });

  final String? title;
  final String? description;
  final Widget body;
  final List<Widget> actions;
  final bool alert;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? description,
    required Widget body,
    List<Widget> actions = const [],
    bool alert = false,
  }) {
    return showShadDialog<T>(
      context: context,
      builder: (_) => ZolyaDialog(
        title: title,
        description: description,
        body: body,
        actions: actions,
        alert: alert,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (alert) {
      return ShadDialog.alert(
        title: title != null ? Text(title!) : null,
        description: description != null ? Text(description!) : null,
        actions: actions,
        child: body,
      );
    }
    return ShadDialog(
      title: title != null ? Text(title!) : null,
      description: description != null ? Text(description!) : null,
      actions: actions,
      child: body,
    );
  }
}
