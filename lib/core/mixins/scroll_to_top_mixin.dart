import 'package:flutter/material.dart';

mixin ScrollToTopMixin<T extends StatefulWidget> on State<T> {

  ScrollController get scrollController;

  Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 350),
    Curve curve = Curves.easeOut,
  }) async {
    if (!scrollController.hasClients) return;
    await scrollController.animateTo(
      0,
      duration: duration,
      curve: curve,
    );
  }
}
