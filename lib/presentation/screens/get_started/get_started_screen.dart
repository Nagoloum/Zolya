import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';
import 'widgets/get_started_content.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetStartedContent(
          onGetStarted: () => context.go(RouteNames.register),
          onLogin: () => context.go(RouteNames.login),
        ),
      ),
    );
  }
}
