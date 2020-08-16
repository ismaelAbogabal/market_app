import 'package:market/utils/location.dart';

import 'category.dart';

class Filter {
  String title;
  Category category;
  double minPrice, maxPrice;
  Location location;
  int distance;
  Order order;
  Scope scope;

  Filter({
    this.title,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.location,
    this.distance,
    this.scope = Scope.city,
    this.order = Order.date,
  });

  Filter.fromMap(Map data)
      : this(
          title: data["title"],
          category: data["category"] != null
              ? Category.fromMap(data["category"])
              : null,
          minPrice: data["minPrice"],
          maxPrice: data["maxPrice"],
          location: data["location"] != null
              ? Location.fromMap(data["location"])
              : null,
          scope: scopeFromString(data["scope"]),
          distance: data["distance"],
          order: orderFromString(data["order"]),
        );

  Map toMap() {
    return {
      "title": title,
      "category": category?.toMap(),
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "location": location?.toMap(),
      "distance": distance,
      "order": order?.toString(),
      "scope": scope.toString(),
    };
  }

  void reset() {
    title = null;
    category = null;
    minPrice = null;
    maxPrice = null;
    distance = null;
  }
}

enum Order { date, priceLTH, priceHTL }

Order orderFromString(String val) {
  if (val == Order.priceLTH.toString()) {
    return Order.priceLTH;
  } else if (val == Order.priceHTL.toString()) {
    return Order.priceHTL;
  } else {
    return Order.date;
  }
}

Scope scopeFromString(String x) {
  if (x == Scope.country.toString()) {
    return Scope.country;
  } else if (x == Scope.region.toString()) {
    return Scope.region;
  } else {
    return Scope.city;
  }
}
