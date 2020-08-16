import 'package:flutter/material.dart';
import 'package:market/screens/splash_screen.dart';
import 'package:market/utils/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageListener extends ChangeNotifier {
  SharedPreferences sharedPreferences;

  LanguageListener();

  String get iWillPay => isEnglish ? "I will Pay " : "اود ان اقدم عرض ب";

  String get setting => isEnglish ? 'Setting' : "الاعدادات";

  String get changeName => isEnglish ? 'Change Name' : "تغير الاسم";
  String get changeLocation => isEnglish ? 'Change Location' : "تغير الموقع";
  String get changeNumber => isEnglish ? 'Change Number' : "تغير الرقم";

  String get notImplemented =>
      isEnglish ? 'Not implemented yet' : "هذه الخاصيه غير مدعومه بعد";

  String get n => isEnglish ? '' : "";

  get name4 => isEnglish
      ? 'Name must be more than 4 characters'
      : "يكون الاسم 5 احرف على الاقل";

  String get submit => isEnglish ? 'Submit' : "تاكيد";

  String get cancel => isEnglish ? 'Cancel' : "الغاء";
  String get email => isEnglish ? 'Email' : "ايميل";

  String get aboutApp => isEnglish ? 'About App' : "عن التطبيف";

  init(SharedPreferences sharedPreferences) {
    isEnglish = sharedPreferences.getBool("isEnglish") ?? false;
    this.sharedPreferences = sharedPreferences;
  }

  setLanguage(bool english) {
    isEnglish = english;
    sharedPreferences.setBool("isEnglish", english);
    notifyListeners();
  }

  bool isEnglish = false;

  String translate(String val) {
//    if (_data[val] == null) return "_____ not found";
    return isEnglish ? val : _data[val] ?? val;
  }

  updateLanguage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Chose language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("English"),
                onTap: () {
                  languageListener.setLanguage(true);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SplashScreen(
                          withoutInit: true,
                        ),
                      ));
                },
              ),
              ListTile(
                title: Text("العربيه"),
                onTap: () {
                  languageListener.setLanguage(false);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SplashScreen(
                          withoutInit: true,
                        ),
                      ));
                },
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(languageListener.translate("Cancel")),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  get weWillWrite =>
      isEnglish ? "we will write the message for you" : "سنكتب لك الرساله ";

  get safetyRules => isEnglish
      ? "Important Safety Tips \n"
          "1- Only meet in public/crowded places for example metro stations and malls.\n"
          "2- Never go alone to meet a buyer/seller, always take someone with you\n"
          "3- Check and inspect the product properly before purchasing it\n"
          "4- Never pay anything in advance or transfer money before inspecting the product\n"
      : "نصائح السلامه \n"
          "۱ - قابل البايع في مكان عام زي المترو أو المولات أو محطات البنزين \n"
          "۲ - خد حد معاك وانت رايح تقابل اي حد \n"
          "۳ - عاين المنتج كويس قبل ما تشتري وتأكد ان سعره مناسب \n"
          "٤ - متدفعش او تحول فلوس الا لما تعاين المنتج كويس \n";

  get changeLanguage => isEnglish ? "Change Language" : "تغير اللغه";

  get login => isEnglish ? "Login" : "تسجيل الدخول";

  get codeError => isEnglish ? "Error in Code" : "خطاء فى الكود";

  get selectCategory => isEnglish ? "Select Category" : "اختيار الفئه";

  get insert8images => isEnglish
      ? "Insert images of your Ad maximum 8 images"
      : "الرجاء ادخال الصور للاعلان";

  static const Map _data = const {
    "Search Scope": "مدى البحث",
    "Country": "دوله",
    "Region": "محافظه",
    "City": "مدينه",

    "Please enter a valid email": "الرجاء ادخال ايميل فعال",
    "Please enter a valid number": "الرجاء ادخال رقم فعال",
    "Log in": "تسجيل الدخول",
    "Logged in as": "تم تسجيل الدخول ك",
    "Main page": "الصفحه الرئيسيه",
    "Browse Ads": "تصفح الاعلانات",
    "Chats": "محادثات",
    "My Ads": "اعلاناتى",
    "Please log in first": "الرجاء تسجيل الدخول اولا",
    "Favorites": "المفضله",
    "Place an Ad": "اضافه اعلان",
    "change Country": "تغير البلد",
    "Logout": "تسجيل الخروج",
    "Message": "رساله",
    "Delete Chat": "حذف محادثه",
    "Archive Chat": "ارشفه المحادثه",
    "Location": "الموقع",
    "Delete": "حذف",
    "Are you sure you want to delete this chat": "هل ترغب حقا فى حذف المحادثه",
    "cancel": "الغاء",
    "Archived": "ارشيف",
    "No Chats Yet": "لا توجد رسايل",
    "No Archived Chats": "لا توجد رسايل مؤرشفه",
    "place an order": "قدم عرض",
    "Send message": "اسال رساله",
    "About": "تفاصيل",
    "All user ads": "جميع اعلانات المستخدم",
    "Please login first": "الرجاء تسجبل الدخول اولا",
    "Customize Your Ad": "تخصيص اعلانك",
    "Clear": "حذف",
    "Enter Ad Title": "الرجاء ادخال عنوان للاعلان",
    "Ad title must be +4 characters": "عنوان الاعلا يكون 4 احرف على الاقل",
    "Title": "عنوان",
    "Please Select Category": "الرجاء اختيار فئه الاعلان",
    "Category": "فئه",
    "Enter Ad Description": "الرجاء ادخال تفاصيل الاعلان",
    "Ad Description must be +20 characters":
        "تفاصيل الالان تكون 20 حرف على الاقل ",
    "description": "تفاصيل ",
    "Price": "سعر",
    "Enter price": "ادخل السعر",
    "Enter a valid price": "ادخل سعر صحيح",
    "select Location": "اختر موقع ",
    "Please Select a Location for your Ad": "الرجاء اختيار موقع للاعلان",
    "Please select a specific location": "اخيار موقع محدد للاعلان",
    "Enter your name": "ادخل اسمك",
    "Name": "الاسم",
    "Edit Ad": "تعديل اعلان",
    "Upload Ad": "رفع اعلان",
    "Contact me : ": "تواصل ",
    "No Ads in this section": "لاتوجد اعلانات ",
    "Favorite": "المفضله",
    "Ads": "اعلانات",
    "Searches": "ابحاث",
    "Search": "بحث",
    "Distance": "مسافه",
    "Min Price": "اقل سعر",
    "Max Price": "اكثر سعر",
    "Market": "سوق",
    "Cant load your location": "لم يتم تحميل موقعك",
    "Browse": "تصفح ",
    "My Location": "موقعى",
    "Current device location error": "مشكله فى تحديد موقع الهاتف الحالى",
    "Chose Location": "اختر موقع",
    "Browse total": "تصفج الكل",
    "Login": "تسجيل الدخول",
    "Get My Number": "اسخراج رقمى",
    "Submit Code": "تسجيل الدخول",
    "Code Time out": "انتهاء وقت التسجيل",
    "Code": "الكود",
    "You": "انت",
    "Select yor country": "اختر بلدك",
    "Cancel": "الغاء",
    "Copy Number": "نسخ الرقم",
    "Add to contacts": "اضافه الى ارقامى",
    "Send sms message": "اسال رساله sms",
    "Call": "اتصال",
    "To": "من",
    "From": "الى",
    "Show": "عرض",
    "Filter": "خيارات البحث",
    "Save": "حفظ البحث",
    "Order": "ترتيب",
    "Date": "تاريخ",
    "Price low to high": "السعر من الاقل للاكثر",
    "Price high to low": "السعر من الاكثر للاقل",
    "Submit": "تاكيد",
    "Edit": "تعديل",
    "Saved Location": "مواقع سابقه",
    // "": "",
  };
}
