import 'package:flutter_bloc/flutter_bloc.dart';

class FollowState {
  const FollowState({this.followedSellerIds = const <String>{}});
  final Set<String> followedSellerIds;

  bool isFollowing(String sellerId) => followedSellerIds.contains(sellerId);

  FollowState copyWith({Set<String>? followedSellerIds}) {
    return FollowState(
      followedSellerIds: followedSellerIds ?? this.followedSellerIds,
    );
  }
}

class FollowCubit extends Cubit<FollowState> {
  FollowCubit() : super(const FollowState());

  void toggle(String sellerId) {
    final next = Set<String>.from(state.followedSellerIds);
    if (next.contains(sellerId)) {
      next.remove(sellerId);
    } else {
      next.add(sellerId);
    }
    emit(state.copyWith(followedSellerIds: next));
  }
}
