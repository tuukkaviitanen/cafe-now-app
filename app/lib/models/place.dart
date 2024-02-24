// ignore_for_file: non_constant_identifier_names

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
  final DayTime close;
  final DayTime open;

  PlaceOpeningHoursPeriod({
    required this.close,
    required this.open,
  });
}

class DayTime {
  final int day;
  final String time;

  DayTime({
    required this.day,
    required this.time,
  });
}

class PlaceOpeningHours {
  final List<PlaceOpeningHoursPeriod>? periods;
  final bool open_now;
  final List<String>? weekday_text;

  PlaceOpeningHours({
    this.periods,
    required this.open_now,
    this.weekday_text,
  });
}

class PlacePhoto {
  final int height;
  final List<String> html_attributions;
  final String photo_reference;
  final int width;

  PlacePhoto({
    required this.height,
    required this.html_attributions,
    required this.photo_reference,
    required this.width,
  });
}

class PlacePlusCode {
  final String compound_code;
  final String global_code;

  PlacePlusCode({
    required this.compound_code,
    required this.global_code,
  });
}

class Place {
  final String? business_status;
  final String? formatted_address;
  final PlaceGeometry geometry;
  final String icon;
  final String name;
  final PlaceOpeningHours? opening_hours;
  final List<PlacePhoto>? photos;
  final String place_id;
  final PlacePlusCode? plus_code;
  final double? rating;
  final String reference;
  final List<String> types;
  final int? user_ratings_total;
  final String? vicinity;
  final String? website;
  final int? price_level;
  final bool? wheelchair_accessible_entrance;

  Place({
    this.business_status,
    this.formatted_address,
    required this.geometry,
    required this.icon,
    required this.name,
    this.opening_hours,
    this.photos,
    required this.place_id,
    this.plus_code,
    this.rating,
    required this.reference,
    required this.types,
    this.user_ratings_total,
    this.vicinity,
    this.website,
    this.price_level,
    this.wheelchair_accessible_entrance,
  });
}
