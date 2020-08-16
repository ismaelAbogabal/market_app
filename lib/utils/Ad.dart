import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:market/screens/add_ad_screen.dart';
import 'package:market/utils/category.dart';
import 'package:market/utils/country.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/location.dart';
import 'package:market/utils/user.dart';

import 'filter.dart';

/* 
  when save ad to firebase it splits it title into list

  Latitude: 1 deg = 110.574 km
  Longitude: 1 deg = 111.320*cos(latitude) km
*/
// ignore: must_be_immutable
class Ad extends Equatable {
  String id;
  String number;
  String userId;
  List<String> images;
  double price;
  String title;
  Category category;
  String description;
  Location location;
  AdState state;
  ContactMe contactMe;
  String name;
  DateTime date;

  bool get isFavorite => favorietAds.contains(this);

  Future<Map> get tokens async {
    var u = await User.fromId(userId);
    return u.tokens;
  }

  Ad({
    this.id,
    this.userId,
    this.number,
    this.name,
    this.price,
    List<String> images,
    this.title,
    this.category,
    this.description,
    this.location,
    this.state,
    this.contactMe = ContactMe.Both,
    this.date,
  }) : this.images = images ?? List();

  Ad.fromMap(Map data)
      : this(
          images: (data["images"] as List).cast<String>(),
          price: (data["price"] as num).toDouble(),
          number: data["number"],
          userId: data["userId"],
          name: data["name"],
          id: data["id"],
          title: data["title"],
          category: data["category"] != null
              ? Category.fromMap(data["category"])
              : null,
          description: data["description"],
          location: Location(
            name: (data["location"] as List).cast<String>(),
            arabicName: (data["locationArabic"] as List)?.cast<String>(),
            lat: data["lat"],
            lon: data["lon"],
          ),
          contactMe: contactMeFromString(data["contactMe"]),
          state: stateFromString(data["state"]),
          date: (data["date"] is Timestamp)
              ? data["date"].toDate()
              : DateTime.tryParse(data["date"]),
        );

  Map toMap({bool convartDate = false}) {
    return {
      "id": id,
      "userId": userId,
      "date": convartDate ? date.toString() : date,
      "price": price,
      "number": number,
      "name": name,
      "images": images,
      "title": title,
      "category": category?.toMap(),
      "description": description,
      "location": location?.name,
      "locationArabic": location?.arabicName,
      "lat": location?.lat,
      "lon": location?.lon,
      "state": state?.toString(),
      "contactMe": contactMe?.toString(),
    };
  }

  static Future<List<Ad>> getAds(Filter filter) async {
    var quary = Firestore.instance
        .collection("Ads")
        .where("category", isEqualTo: filter?.category?.toMap());

    var r = await quary.getDocuments();
    return r.documents.map((e) => Ad.fromMap(e.data)).where((a) {
      if (filter?.location == null) {
        if (a.location.name.first != Country.country.name) {
          return false;
        }
      } else {
        if (filter.distance == null) {
          if (filter.scope == null || filter.scope == Scope.city) {
            if (filter.location.name[2] != a.location.name[2]) return false;
          } else if (filter.scope == Scope.region) {
            if (filter.location.name[1] != a.location.name[1]) return false;
          } else if (filter.scope == Scope.country) {
            if (filter.location.name[0] != a.location.name[0]) return false;
          }
        } else {
          double distance = getDistance(filter.location.lat,
              filter.location.lon, a.location.lat, a.location.lon);

          if (distance > filter.distance * 1000) return false;
        }
      }
      if (filter == null) return true;

      if (filter.title != null && !a.title.contains(filter.title)) {
        return false;
      }

      if (filter.category != null && filter.category != a.category)
        return false;

      if (filter.maxPrice != null && a.price > filter.maxPrice) return false;
      if (filter.minPrice != null && a.price < filter.maxPrice) return false;
      return true;
    }).toList()
      ..sort((Ad a, Ad b) {
        if (filter.order == Order.date) {
          return b.date.compareTo(a.date);
        } else if (filter.order == Order.priceLTH) {
          return a.price.compareTo(b.price);
        } else if (filter.order == Order.priceHTL) {
          return b.price.compareTo(a.price);
        }
        return 0;
      });
  }

  static Future<List<Ad>> getUserAds(String id) async {
    var quary =
        Firestore.instance.collection("Ads").where("userId", isEqualTo: id);

    var r = await quary.getDocuments();
    return r.documents.map((e) => Ad.fromMap(e.data)).toList();
  }

  @override
  List<Object> get props => [id];
}

enum AdState { disabled, active }

AdState stateFromString(String x) {
  if (x == AdState.active.toString()) {
    return AdState.active;
  } else {
    return AdState.disabled;
  }
}

rad(x) {
  return x * pi / 180;
}

getDistance(double p1Lat, double p1Lon, double p2Lat, double p2Lon) {
  var R = 6378137; // Earth’s mean radius in meter
  var dLat = rad(p2Lat - p1Lat);
  var dLong = rad(p2Lon - p1Lon);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(rad(p1Lat)) * cos(rad(p2Lat)) * sin(dLong / 2) * sin(dLong / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var d = R * c;
  return d; // returns the distance in meter
}
