class Response {
  final double version;
  final String generator;
  final List<Place> elements;

  Response({
    required this.version,
    required this.generator,
    required this.elements,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      version: json['version'],
      generator: json['generator'],
      elements: List<Place>.from(
          json['elements'].map((x) => Place.fromJson(x)).toList()),
    );
  }
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

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      type: json['type'],
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      tags: Tags.fromJson(json['tags']),
    );
  }
}

class Tags {
  final String name;
  final String? website;
  final String? phone;
  final String? openingHours;
  final String? street;
  final String? housenumber;
  final String? postcode;
  final String? city;
  final String? country;
  final String? email;

  String? getAddress() {
    if (street == null || housenumber == null || city == null) {
      return null;
    }

    return '$street $housenumber, $city';
  }

  Tags({
    required this.name,
    this.website,
    this.phone,
    this.openingHours,
    this.street,
    this.housenumber,
    this.postcode,
    this.city,
    this.country,
    this.email,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      name: json['name'],
      website: json['website'],
      phone: json['phone'],
      openingHours: (json['opening_hours'] as String?)
          ?.split(';')
          .map((x) => x.trim())
          .join('\n'),
      street: json['addr:street'],
      housenumber: json['addr:housenumber'],
      postcode: json['addr:postcode'],
      city: json['addr:city'],
      country: json['addr:country'],
      email: json['email'],
    );
  }
}
