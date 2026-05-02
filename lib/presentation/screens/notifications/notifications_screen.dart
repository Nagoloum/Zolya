import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/repositories/notification_feed_repository.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/notifications/notifications_cubit.dart';
import '../../bloc/notifications/notifications_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/notification_tile.dart';
import 'widgets/notifications_empty.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return BlocProvider<NotificationsCubit>(
      create: (_) =>
          NotificationsCubit(repo: sl<NotificationFeedRepository>())..load(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ZolyaTopBar(title: l.notificationsTitle, centerTitle: true),
        body: SafeArea(
          child: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoading ||
                  state is NotificationsInitial) {
                return const Center(child: ZolyaSpinner());
              }
              if (state is NotificationsError) {
                return ZolyaEmptyState(
                  icon: Icons.error_outline,
                  title: state.message,
                );
              }
              final groups = (state as NotificationsLoaded).groups;
              if (groups.isEmpty) {
                return NotificationsEmpty(
                  title: l.notificationsEmptyTitle,
                  body: l.notificationsEmptyBody,
                );
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [for (final g in groups) _Group(group: g)],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.group});
  final NotificationGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: ZolyaSpacing.md, bottom: 4),
          child: Text(group.title, style: ZolyaTypography.title),
        ),
        for (final item in group.items) NotificationTile(data: item),
      ],
    );
  }
}
