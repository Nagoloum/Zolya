import 'package:equatable/equatable.dart';

import '../../../data/fake/ui_models.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded({required this.groups});
  final List<NotificationGroup> groups;

  @override
  List<Object?> get props => [groups];
}

class NotificationsError extends NotificationsState {
  const NotificationsError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
