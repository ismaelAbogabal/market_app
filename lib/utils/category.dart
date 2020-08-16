import 'package:equatable/equatable.dart';
import 'package:market/utils/category_list.dart';
import 'package:market/utils/data.dart';

import 'additional_data.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  static final Category root = Category(name: "root");

  final String name;
  final String arabicName;
  final int code;
  final String image;
  final List<Category> sons;

  final List<AdditionalData> data;

  get hasSons => sons != null && sons.isNotEmpty;
  get hasImage => image != null;

  const Category({
    this.name,
    this.arabicName,
    this.code,
    this.image,
    this.sons,
    this.data,
  });

  String get translatedName => languageListener.isEnglish ? name : arabicName;

  @override
  String toString() {
    return name;
  }

  static Category fromMap(Map data) {
    Category c = Category(
      name: data["name"],
      arabicName: data["arabicName"],
      image: data["image"],
      code: data["code"],
      sons: ((data["subList"] ?? []) as List)
          ?.map((e) => Category.fromMap(e))
          ?.toList(),
    );
    return c;
  }

  static List<Category> getAll() {
    return all;
  }

  toMap() {
    return {
      "name": name,
      "code": code,
    };
  }

  @override
  List<Object> get props => [name];
}
