// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Map<String, Welcome> welcomeFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Welcome>(k, Welcome.fromJson(v)));

String welcomeToJson(Map<String, Welcome> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Welcome {
    Welcome({
        required this.icao,
        this.iata,
        required this.name,
        required this.city,
        this.state,
        required this.country,
        required this.elevation,
        required this.lat,
        required this.lon,
        required this.tz,
    });

    String icao;
    String? iata;
    String name;
    String city;
    String? state;
    String country;
    int elevation;
    double lat;
    double lon;
    String tz;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        icao: json["icao"],
        iata: json["iata"],
        name: json["name"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        elevation: json["elevation"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        tz: json["tz"],
    );

    Map<String, dynamic> toJson() => {
        "icao": icao,
        "iata": iata,
        "name": name,
        "city": city,
        "state": state,
        "country": country,
        "elevation": elevation,
        "lat": lat,
        "lon": lon,
        "tz": tz,
    };
}
