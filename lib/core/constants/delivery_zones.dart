enum DeliveryZone { zone1, zone2, zone3 }

class DeliveryZoneInfo {
  final DeliveryZone zone;
  final String label;
  final int feeFcfa;
  final String description;
  final List<String> neighborhoods;

  const DeliveryZoneInfo({
    required this.zone,
    required this.label,
    required this.feeFcfa,
    required this.description,
    required this.neighborhoods,
  });
}

abstract class DeliveryZones {
  static const DeliveryZoneInfo zone1 = DeliveryZoneInfo(
    zone: DeliveryZone.zone1,
    label: 'Zone 1 — Centre-ville',
    feeFcfa: 1500,
    description: 'Zone dense, forte activité commerciale',
    neighborhoods: ['Akwa', 'Bonanjo', 'Bali', 'Deido centre', 'Bonapriso', 'New Bell'],
  );

  static const DeliveryZoneInfo zone2 = DeliveryZoneInfo(
    zone: DeliveryZone.zone2,
    label: 'Zone 2 — Proche centre',
    feeFcfa: 1000,
    description: 'Zones résidentielles et commerciales mixtes',
    neighborhoods: ['Bonamoussadi', 'Makepe', 'Kotto', 'Bepanda', 'Ndokoti', 'PK8', 'Logbaba', 'Akwa Nord', 'Logpom'],
  );

  static const DeliveryZoneInfo zone3 = DeliveryZoneInfo(
    zone: DeliveryZone.zone3,
    label: 'Zone 3 — Périphérie',
    feeFcfa: 2000,
    description: 'Longues distances, coûts logistiques élevés',
    neighborhoods: ['PK10', 'PK11', 'PK12', 'Yassa', 'Nyalla', 'Japoma', 'Bonabéri', 'Lendi'],
  );

  static const List<DeliveryZoneInfo> all = [zone1, zone2, zone3];

  static DeliveryZoneInfo? fromNeighborhood(String neighborhood) {
    for (final zone in all) {
      if (zone.neighborhoods.any((n) => n.toLowerCase() == neighborhood.toLowerCase())) {
        return zone;
      }
    }
    return null;
  }

  static DeliveryZoneInfo fromZone(DeliveryZone zone) {
    return all.firstWhere((z) => z.zone == zone);
  }
}
