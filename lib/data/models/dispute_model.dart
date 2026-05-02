import '../../domain/entities/dispute.dart';

class DisputeModel extends Dispute {
  const DisputeModel({
    required super.id,
    required super.orderId,
    required super.openedBy,
    required super.reason,
    required super.description,
    super.status,
    super.resolutionNote,
    super.resolvedBy,
    super.attachmentUrls,
    required super.createdAt,
    super.resolvedAt,
  });

  factory DisputeModel.fromJson(Map<String, dynamic> json) => DisputeModel(
        id: json['id'] as String,
        orderId: json['order_id'] as String,
        openedBy: json['opened_by'] as String,
        reason: _reasonFromString(json['reason'] as String),
        description: json['description'] as String,
        status: _statusFromString(json['status'] as String? ?? 'open'),
        resolutionNote: json['resolution_note'] as String?,
        resolvedBy: json['resolved_by'] as String?,
        attachmentUrls: List<String>.from(json['attachment_urls'] as List? ?? []),
        createdAt: DateTime.parse(json['created_at'] as String),
        resolvedAt: json['resolved_at'] != null
            ? DateTime.parse(json['resolved_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'opened_by': openedBy,
        'reason': _reasonToString(reason),
        'description': description,
        'status': _statusToString(status),
      };

  static DisputeReason _reasonFromString(String s) => switch (s) {
        'non_conforme' => DisputeReason.nonConforme,
        'non_recu' => DisputeReason.nonRecu,
        _ => DisputeReason.autre,
      };

  static String _reasonToString(DisputeReason r) => switch (r) {
        DisputeReason.nonConforme => 'non_conforme',
        DisputeReason.nonRecu => 'non_recu',
        DisputeReason.autre => 'autre',
      };

  static DisputeStatus _statusFromString(String s) => switch (s) {
        'investigating' => DisputeStatus.investigating,
        'resolved_buyer' => DisputeStatus.resolvedBuyer,
        'resolved_seller' => DisputeStatus.resolvedSeller,
        'closed' => DisputeStatus.closed,
        _ => DisputeStatus.open,
      };

  static String _statusToString(DisputeStatus s) => switch (s) {
        DisputeStatus.open => 'open',
        DisputeStatus.investigating => 'investigating',
        DisputeStatus.resolvedBuyer => 'resolved_buyer',
        DisputeStatus.resolvedSeller => 'resolved_seller',
        DisputeStatus.closed => 'closed',
      };
}
