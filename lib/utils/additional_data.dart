import 'package:market/utils/data.dart';

abstract class AdditionalData {
  final String name;
  final String arabicName;

  const AdditionalData({
    this.name,
    this.arabicName,
  });

  get translatedName => languageListener.isEnglish ? name : arabicName;
}

class AdditionalDataNumber extends AdditionalData {}

class Item {}

class AdditionalDataOneFromMulti extends AdditionalData {
  final List<Item> items;

  const AdditionalDataOneFromMulti({
    String name,
    String arabicName,
    this.items,
  }) : super(
          name: name,
          arabicName: arabicName,
        );
}

class AdditionalDataMultiFromMulti extends AdditionalData {
  final List<Item> items;

  const AdditionalDataMultiFromMulti({
    String name,
    String arabicName,
    this.items,
  }) : super(
          name: name,
          arabicName: arabicName,
        );
}
