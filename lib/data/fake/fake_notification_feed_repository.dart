import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/notification_feed_repository.dart';
import 'fake_data.dart';
import 'ui_models.dart';

class FakeNotificationFeedRepository implements NotificationFeedRepository {
  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<NotificationGroup>>> getFeed() async {
    await _latency();
    return const Right(FakeData.notifications);
  }
}
