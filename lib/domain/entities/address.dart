import 'package:equatable/equatable.dart';
import '../../core/constants/delivery_zones.dart';

class Address extends Equatable {
  final String id;
  final String userId;
  final String? label;
  final DeliveryZone zone;
  final String neighborhood;
  final String? street;
  final String? landmark;
  final String phoneContact;
  final String? instructions;
  final bool isDefault;

  const Address({
    required this.id,
    required this.userId,
    this.label,
    required this.zone,
    required this.neighborhood,
    this.street,
    this.landmark,
    required this.phoneContact,
    this.instructions,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id, userId, neighborhood, zone, isDefault];
}
