import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';
import '../../bloc/splash/splash_cubit.dart';
import '../../bloc/splash/splash_state.dart';
import 'widgets/splash_content.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..start(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashReady) {
            context.go(RouteNames.getStarted);
          }
        },
        child: const Scaffold(
          body: SplashContent(),
        ),
      ),
    );
  }
}
