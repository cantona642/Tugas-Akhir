class Location {
  final double latitude;
  final double longitude;

  final int time;
  final double speed;
  final double horizontalAccuracy;
  final double verticalAccuracy;

  const Location(latitude, longitude) :
      latitude = latitude,
      longitude = longitude,
      time = 0,
      speed = 0.0,
      horizontalAccuracy = 0.0,
      verticalAccuracy = 0.0;

  Location.full(this.latitude, this.longitude, this.time, this.speed, this.horizontalAccuracy, this.verticalAccuracy);

  factory Location.fromMap(Map map){
    return new Location(map["latitude"], map["longitude"]);
  }

  factory Location.fromMapFull(Map map) {
    return new Location.full(
      map["latitude"],
      map["longitude"],
      map["time"],
      map["speed"],
      map["horizontalAccuracy"],
      map["verticalAccuracy"],
    );
  }
  static List<Map<String, dynamic>> listToMap(List<Location> list) {
    List<Map<String, dynamic>> result = [];
    for (var element in list) {
      result.add(element.toMap());
    }
    return result;
  }

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
    "time": time,
    "speed": speed,
    "horizontalAccuracy": horizontalAccuracy,
    "verticalAccuracy": verticalAccuracy,
  };

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, time: $time, speed: $speed, horizontalAccuracy: $horizontalAccuracy, verticalAccuracy: $verticalAccuracy}';
  }
}