import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';
import 'package:market/widgets/chose_country.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Country {
  final String name;
  final String arabicName;
  final String flag;
  final String code;

  const Country({this.code, this.arabicName, this.name, this.flag});

  String get translatedName => languageListener.isEnglish ? name : arabicName;

  static List<Country> countries = const [
    const Country(
      name: "Egypt",
      arabicName: "مصر",
      code: "EG",
      flag: "assets/flags/eg_flag.jpg",
    ),
    const Country(
      name: "Jordan",
      arabicName: "الاردن",
      code: "JO",
      flag: "assets/flags/jo_flag.dart.jpg",
    ),
    const Country(
      name: "Kuwait",
      arabicName: "الكويت",
      code: "KW",
      flag: "assets/flags/kw_flag.jpg",
    ),
    const Country(
      name: "Lebanon",
      arabicName: "لبنان",
      code: "LB",
      flag: "assets/flags/lb_flag.jpg",
    ),
    const Country(
      name: "Oman",
      arabicName: "عمان",
      code: "OM",
      flag: "assets/flags/om_flag.jpg",
    ),
    const Country(
      name: "Qatar",
      arabicName: "قطر",
      code: "QA",
      flag: "assets/flags/qt_flag.jpg",
    ),
    const Country(
      name: "saudi Arabia",
      arabicName: "السعوديه",
      code: "SA",
      flag: "assets/flags/so_flag.jpg",
    ),
  ];

  static void init(SharedPreferences ref) {
    String name = ref.getString("country");
    if (name != null)
      _country = countries.where((element) => element.name == name).first;
  }

  static Country _country;
  static Country get country => _country;
  static setCountry(Country country) async {
    _country = country;
    var pref = await SharedPreferences.getInstance();
    pref.setString("country", _country.name);
  }

  static updateCountry(BuildContext context) async {
    await showDialog(context: context, builder: (c) => ChoseCountry());
  }
}
