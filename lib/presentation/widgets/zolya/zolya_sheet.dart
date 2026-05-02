import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ZolyaSheet extends StatelessWidget {
  const ZolyaSheet({
    super.key,
    this.title,
    this.description,
    required this.body,
    this.actions = const [],
  });

  final String? title;
  final String? description;
  final Widget body;
  final List<Widget> actions;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? description,
    required Widget body,
    List<Widget> actions = const [],
    ShadSheetSide side = ShadSheetSide.bottom,
  }) {
    return showShadSheet<T>(
      context: context,
      side: side,
      builder: (_) => ZolyaSheet(
        title: title,
        description: description,
        body: body,
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadSheet(
      title: title != null ? Text(title!) : null,
      description: description != null ? Text(description!) : null,
      actions: actions,
      child: body,
    );
  }
}
