import 'package:equatable/equatable.dart';

enum DisputeReason { nonConforme, nonRecu, autre }

enum DisputeStatus {
  open,
  investigating,
  resolvedBuyer,
  resolvedSeller,
  closed,
}

class Dispute extends Equatable {
  final String id;
  final String orderId;
  final String openedBy;
  final DisputeReason reason;
  final String description;
  final DisputeStatus status;
  final String? resolutionNote;
  final String? resolvedBy;
  final List<String> attachmentUrls;
  final DateTime createdAt;
  final DateTime? resolvedAt;

  const Dispute({
    required this.id,
    required this.orderId,
    required this.openedBy,
    required this.reason,
    required this.description,
    this.status = DisputeStatus.open,
    this.resolutionNote,
    this.resolvedBy,
    this.attachmentUrls = const [],
    required this.createdAt,
    this.resolvedAt,
  });

  bool get isOpen => status == DisputeStatus.open || status == DisputeStatus.investigating;

  String get reasonLabel => switch (reason) {
        DisputeReason.nonConforme => 'Article non conforme',
        DisputeReason.nonRecu => 'Colis non reçu',
        DisputeReason.autre => 'Autre',
      };

  @override
  List<Object?> get props => [id, orderId, status];
}
