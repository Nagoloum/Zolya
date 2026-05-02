import '../../core/constants/delivery_zones.dart';
import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.userId,
    super.label,
    required super.zone,
    required super.neighborhood,
    super.street,
    super.landmark,
    required super.phoneContact,
    super.instructions,
    super.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        label: json['label'] as String?,
        zone: _zoneFromCode(json['zone_code'] as String? ?? 'zone1'),
        neighborhood: json['neighborhood'] as String,
        street: json['street'] as String?,
        landmark: json['landmark'] as String?,
        phoneContact: json['phone_contact'] as String? ?? '',
        instructions: json['instructions'] as String?,
        isDefault: json['is_default'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'label': label,
        'neighborhood': neighborhood,
        'street': street,
        'landmark': landmark,
        'phone_contact': phoneContact,
        'instructions': instructions,
        'is_default': isDefault,
      };

  static DeliveryZone _zoneFromCode(String code) => switch (code) {
        'zone2' => DeliveryZone.zone2,
        'zone3' => DeliveryZone.zone3,
        _ => DeliveryZone.zone1,
      };
}
