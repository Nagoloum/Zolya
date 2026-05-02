import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/notification_feed_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required this.repo}) : super(const NotificationsInitial());

  final NotificationFeedRepository repo;

  Future<void> load() async {
    emit(const NotificationsLoading());
    final result = await repo.getFeed();
    result.fold(
      (failure) => emit(NotificationsError(message: failure.toString())),
      (groups) => emit(NotificationsLoaded(groups: groups)),
    );
  }
}
