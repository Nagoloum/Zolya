import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> start({Duration minDuration = const Duration(seconds: 2)}) async {
    emit(const SplashLoading());
    await Future.delayed(minDuration);
    emit(const SplashReady());
  }
}
