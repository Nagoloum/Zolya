import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/fake/ui_models.dart';

abstract class NotificationFeedRepository {
  Future<Either<Failure, List<NotificationGroup>>> getFeed();
}
