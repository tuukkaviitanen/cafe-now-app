// ignore_for_file: non_constant_identifier_names

class Response {
  final String version;
  final String generator;
  final List<Place> elements;

  Response({
    required this.version,
    required this.generator,
    required this.elements,
  });
}

class Place {
  final String type;
  final int id;
  final double lat;
  final double lon;
  final Tags tags;

  Place({
    required this.type,
    required this.id,
    required this.lat,
    required this.lon,
    required this.tags,
  });
}

class Tags {
  final String name;
  final String? website;
  final String? phone;
  final String? opening_hours;

  Tags({
    required this.name,
    this.website,
    this.phone,
    this.opening_hours,
  });
}
