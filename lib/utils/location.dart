import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:market/utils/constants.dart';
import 'package:market/utils/data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

enum Scope { country, region, city }

class Location extends Equatable {
  final List<String> name;
  final List<String> arabicName;
  final double lon;
  final double lat;

  const Location({this.name, this.arabicName, this.lon, this.lat});

  String get translatedAddress => languageListener.isEnglish
      ? name.toString().replaceAll("[", "").replaceAll("]", "")
      : arabicName.toString().replaceAll("[", "").replaceAll("]", "");

  String get translatedLast =>
      languageListener.isEnglish ? name?.last : arabicName?.last;

  Location.fromMap(Map data)
      : this(
          name: (data['name'] as List).cast<String>(),
          arabicName: (data['arabicName'] as List).cast<String>(),
          lat: data["lat"],
          lon: data["lon"],
        );

  Map toMap() {
    return {
      "name": name,
      "arabicName": arabicName,
      "lat": lat,
      "lon": lon,
    };
  }

  static Future getLocation(BuildContext context) async {
    var result = await showLocationPicker(
      context,
      mapApi,
      myLocationButtonEnabled: true,
      automaticallyAnimateToCurrentLocation: false,
      initialCenter: locationListener.location != null
          ? LatLng(locationListener.location.lat, locationListener.location.lon)
          : const LatLng(45.521563, -122.677433),
    );
    if (result == null) return;

    var mark = await Geolocator().placemarkFromCoordinates(
      result.latLng.latitude,
      result.latLng.longitude,
      localeIdentifier: "en",
    );

    var arabicMark = await Geolocator().placemarkFromCoordinates(
      result.latLng.latitude,
      result.latLng.longitude,
      localeIdentifier: "ar",
    );

    return Location(
      name: [
        mark[0].country,
        mark[0].administrativeArea,
        mark[0].subAdministrativeArea
      ],
      arabicName: [
        arabicMark[0].country,
        arabicMark[0].administrativeArea,
        arabicMark[0].subAdministrativeArea,
      ],
      lon: mark[0].position.longitude,
      lat: mark[0].position.latitude,
    );
  }

  static Future updateLocation(BuildContext context) async {
    Location l = await getLocation(context);
    if (l != null) locationListener.location = l;
  }

  @override
  List<Object> get props => [name, lon, lat];
}

class LocationListener extends ChangeNotifier {
  List<Location> _lastLocations = [];

  init(SharedPreferences sharedPreferences) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      File f = File("${directory.path}/location.json");
      String val = f?.readAsStringSync();
      if (val == null || val.isEmpty) return;
      List l = jsonDecode(val);
      _lastLocations = l.map((e) => Location.fromMap(e)).toList();
      notifyListeners();
    } catch (e) {}
  }

  void save() async {
    _lastLocations.remove(null);
    final directory = await getApplicationDocumentsDirectory();
    File f = File("${directory.path}/location.json");
    f.writeAsString(jsonEncode(_lastLocations.map((e) => e.toMap()).toList()));
  }

  set location(Location location) {
    _lastLocations.removeWhere((c) => c == location);
    _lastLocations.insert(0, location);
    if (_lastLocations.length > 4)
      _lastLocations = _lastLocations.getRange(0, 3).toList();

    cUser?.updateLocation(location);
    notifyListeners();
    save();
  }

  Location get location =>
      _lastLocations.length > 0 ? _lastLocations.first : null;

  List<Location> get savedLocations => _lastLocations.cast();
}
