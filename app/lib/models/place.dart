class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });
}

class PlaceGeometry {
  final Location location;
  final PlaceViewport viewport;

  PlaceGeometry({
    required this.location,
    required this.viewport,
  });
}

class PlaceViewport {
  final Location northeast;
  final Location southwest;

  PlaceViewport({
    required this.northeast,
    required this.southwest,
  });
}

class PlaceOpeningHoursPeriod {
  final PlaceOpeningHours close;
  final PlaceOpeningHours open;

  PlaceOpeningHoursPeriod({
    required this.close,
    required this.open,
  });
}

class PlaceOpeningHours {
  final int day;
  final String time;

  PlaceOpeningHours({
    required this.day,
    required this.time,
  });
}

class PlacePhoto {
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  PlacePhoto({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });
}

class PlacePlusCode {
  final String compoundCode;
  final String globalCode;

  PlacePlusCode({
    required this.compoundCode,
    required this.globalCode,
  });
}

class Place {
  final String? businessStatus;
  final String? formattedAddress;
  final PlaceGeometry geometry;
  final String icon;
  final String name;
  final PlaceOpeningHours? openingHours;
  final List<PlacePhoto>? photos;
  final String placeId;
  final PlacePlusCode? plusCode;
  final double? rating;
  final String reference;
  final List<String> types;
  final int? userRatingsTotal;

  Place({
    this.businessStatus,
    this.formattedAddress,
    required this.geometry,
    required this.icon,
    required this.name,
    this.openingHours,
    this.photos,
    required this.placeId,
    this.plusCode,
    this.rating,
    required this.reference,
    required this.types,
    this.userRatingsTotal,
  });
}
