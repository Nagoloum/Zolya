import 'package:flutter/material.dart';

import '../../../theme/zolya_theme.dart';

class ZolyaScaffold extends StatelessWidget {
  const ZolyaScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.padding = const EdgeInsets.symmetric(
      horizontal: ZolyaSpacing.lg,
      vertical: ZolyaSpacing.lg,
    ),
    this.scroll = true,
    this.centerContent = false,
    this.background,
    this.resizeToAvoidBottomInset,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final EdgeInsets padding;
  final bool scroll;
  final bool centerContent;
  final Color? background;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content = Padding(
      padding: padding,
      child: body,
    );

    if (centerContent) {
      content = Center(child: content);
    }

    if (scroll) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    return Scaffold(
      backgroundColor: background ?? theme.scaffoldBackgroundColor,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(child: content),
    );
  }
}
