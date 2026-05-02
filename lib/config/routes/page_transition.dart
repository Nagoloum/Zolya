import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/widgets/zolya/zolya_spinner.dart';

/// Wraps a page with a brief loading state then fades the content in.
/// Used as the default `pageBuilder` for go_router routes so every navigation
/// shows a consistent themed loading state on transition.
CustomTransitionPage<void> zolyaTransitionPage({
  required Widget child,
  LocalKey? key,
  Duration loaderDuration = const Duration(milliseconds: 220),
  Duration fadeDuration = const Duration(milliseconds: 240),
}) {
  return CustomTransitionPage<void>(
    key: key,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    child: _PageWithLoader(
      loaderDuration: loaderDuration,
      fadeDuration: fadeDuration,
      child: child,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).animate(curved),
          child: page,
        ),
      );
    },
  );
}

class _PageWithLoader extends StatefulWidget {
  const _PageWithLoader({
    required this.child,
    required this.loaderDuration,
    required this.fadeDuration,
  });

  final Widget child;
  final Duration loaderDuration;
  final Duration fadeDuration;

  @override
  State<_PageWithLoader> createState() => _PageWithLoaderState();
}

class _PageWithLoaderState extends State<_PageWithLoader> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.loaderDuration, () {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _ready ? 1 : 0,
          duration: widget.fadeDuration,
          curve: Curves.easeOut,
          child: widget.child,
        ),
        if (!_ready)
          Positioned.fill(
            child: ColoredBox(
              color: theme.scaffoldBackgroundColor,
              child: const Center(
                child: ZolyaSpinner(size: ZolyaSpinnerSize.md),
              ),
            ),
          ),
      ],
    );
  }
}

/// Helper that adapts a builder callback into a `pageBuilder` returning a
/// `zolyaTransitionPage`.
Page<void> Function(BuildContext, GoRouterState) zolyaPageBuilder(
  Widget Function(BuildContext, GoRouterState) builder,
) {
  return (context, state) =>
      zolyaTransitionPage(child: builder(context, state), key: state.pageKey);
}

/// Convenience for routes that ignore the state.
Page<void> Function(BuildContext, GoRouterState) zolyaPageBuilderSimple(
  Widget Function() builder,
) {
  return (context, state) =>
      zolyaTransitionPage(child: builder(), key: state.pageKey);
}
