import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/product_comment.dart';

class CommentsState {
  const CommentsState({this.byProduct = const {}, this.loading = false});
  final Map<String, List<ProductComment>> byProduct;
  final bool loading;

  List<ProductComment> commentsFor(String productId) =>
      byProduct[productId] ?? const <ProductComment>[];

  CommentsState copyWith({
    Map<String, List<ProductComment>>? byProduct,
    bool? loading,
  }) =>
      CommentsState(
        byProduct: byProduct ?? this.byProduct,
        loading: loading ?? this.loading,
      );
}

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(const CommentsState());

  void seedFor(String productId) {
    if (state.byProduct.containsKey(productId)) return;
    final hash = productId.codeUnits.fold<int>(0, (a, b) => a + b);
    final samples = [
      'Hi, is this still available?',
      'Can you ship to Yaoundé?',
      'Beautiful piece — what are the actual measurements?',
      'Would you accept 80% of the asking price?',
    ];
    final now = DateTime.now();
    final demo = <ProductComment>[
      ProductComment(
        id: 'c-$productId-1',
        productId: productId,
        authorId: 'u-${100 + (hash % 50)}',
        authorName: 'Aïssa M.',
        authorAvatarUrl: 'https://i.pravatar.cc/150?img=44',
        text: samples[hash % samples.length],
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      ProductComment(
        id: 'c-$productId-2',
        productId: productId,
        authorId: 'u-${200 + (hash % 50)}',
        authorName: 'Karim B.',
        text: samples[(hash + 1) % samples.length],
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    ];
    final next = Map<String, List<ProductComment>>.from(state.byProduct);
    next[productId] = demo;
    emit(state.copyWith(byProduct: next));
  }

  void post({
    required String productId,
    required String text,
    int rating = 0,
  }) {
    final user = FakeData.currentUser;
    final comment = ProductComment(
      id: 'c-${DateTime.now().microsecondsSinceEpoch}',
      productId: productId,
      authorId: user.id,
      authorName: user.fullName,
      authorAvatarUrl: user.avatarUrl,
      text: text.trim(),
      rating: rating,
      createdAt: DateTime.now(),
    );
    final next = Map<String, List<ProductComment>>.from(state.byProduct);
    next[productId] = [comment, ...(next[productId] ?? const [])];
    emit(state.copyWith(byProduct: next));
  }
}
