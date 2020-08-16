import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/widgets/category_slector_alert.dart';
import 'package:market/widgets/triple_row.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';

class AddAdScreen extends StatefulWidget {
  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  Ad ad;

  bool edit;

  //images in queue
  List<Asset> images = [];
  TextEditingController email = TextEditingController();

  static const padding = 10.0;
  final key = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  onLocationChanged() {
    setState(() {});
  }

  @override
  void initState() {
    locationListener.addListener(onLocationChanged);
    super.initState();
  }

  @override
  void dispose() {
    locationListener.removeListener(onLocationChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cUser == null) {
      Toast.show(languageListener.translate("Please login first"), context);
      Navigator.pop(context);
    }
    if (ad == null) {
      ad = ModalRoute.of(context).settings.arguments;
      titleController.text = ad?.title;
      descriptionController.text = ad?.description;
      priceController.text = ad?.price?.toString();

      edit = true;
      if (ad == null) {
        edit = false;
        ad = Ad(
          id: Firestore.instance.collection("Ads").document().documentID,
          state: AdState.active,
          userId: cUser.uid,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(languageListener.translate("Customize Your Ad")),
      ),
      body: Form(
        key: key,
        child: ListView(
          children: <Widget>[
            TripleRow(
              state: images != null && ad.images.isNotEmpty,
              onRemove: () {
                setState(() {
                  images.clear();
                  ad.images.clear();
                });
              },
              field: Align(
                alignment: Alignment.topRight,
                child: Text(languageListener.insert8images),
              ),
            ),
            buildImagesSection(),
            SizedBox(height: padding),
            TripleRow(
              onRemove: () {
                setState(() {
                  ad.title = null;
                  titleController.text = "";
                });
              },
              state: titleController.text?.isNotEmpty ?? false,
              field: TextFormField(
                controller: titleController,
                validator: (c) {
                  if (c.isEmpty) {
                    return languageListener.translate("Enter Ad Title");
                  } else if (c.length < 4) {
                    return languageListener
                        .translate("Ad title must be +4 characters");
                  }
                  ad.title = titleController.text;
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: languageListener.translate("Title")),
              ),
            ),
            SizedBox(height: padding),
            TripleRow(
              onRemove: () {
                setState(() {
                  ad.category = null;
                });
              },
              state: ad.category != null,
              field: TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return languageListener.translate("Please Select Category");
                  }
                  return null;
                },
                readOnly: true,
                onTap: updateCategory,
                controller:
                    TextEditingController(text: ad.category?.translatedName),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: languageListener.translate("Category"),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
            SizedBox(height: padding),
            TripleRow(
              state: descriptionController.text.isNotEmpty,
              field: TextFormField(
                controller: descriptionController,
                validator: (c) {
                  if (c.isEmpty) {
                    return languageListener.translate("Enter Ad Description");
                  } else if (c.length < 20) {
                    return languageListener
                        .translate("Ad Description must be +20 characters");
                  }
                  ad.description = descriptionController.text;
                  return null;
                },
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: languageListener.translate("description"),
                ),
              ),
            ),
            SizedBox(height: padding),
            TripleRow(
              onRemove: () {
                setState(() {
                  priceController.text = "";
                  ad.price = null;
                });
              },
              state: priceController.text.isNotEmpty,
              field: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: languageListener.translate("Price")),
                validator: (x) {
                  if (x.isEmpty)
                    return languageListener.translate("Enter price");
                  double p = double.tryParse(x);
                  if (p == null)
                    return languageListener.translate("Enter a valid price");
                  ad.price = p;
                  return null;
                },
              ),
            ),
            SizedBox(height: padding),
            // if (ad.category != null)
            //   for (var d in ad.category.data ?? [])
            //     _buildAdditionalDataInput(d),
            TripleRow(
              state: email.text.isNotEmpty &&
                  email.text.endsWith(".com") &&
                  email.text.contains("@"),
              field: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isNotEmpty &&
                      value.contains(".com") &&
                      value.contains("@"))
                    return null;
                  else
                    return languageListener
                        .translate("Please enter a valid email");
                },
                decoration: InputDecoration(labelText: languageListener.email),
              ),
            ),
            TripleRow(
              icon: Icon(Icons.location_on),
              state: ad.location != null || locationListener.location != null,
              field: TextFormField(
                controller: TextEditingController(
                    text: locationListener.location?.translatedLast ??
                        languageListener.translate("select Location")),
                readOnly: true,
                onTap: () => Location.updateLocation(context),
                validator: (x) {
                  if (locationListener.location == null)
                    return languageListener
                        .translate("Please Select a Location for your Ad");
                  else if (locationListener.location.lat == null)
                    return languageListener
                        .translate("Please select a specific location");
                  else if (locationListener.location.lon == null)
                    return languageListener
                        .translate("Please select a specific location");
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: languageListener.translate("Location"),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
            SizedBox(height: padding),
            TripleRow(
              icon: Icon(Icons.person, color: Colors.white),
              state: ad.name != null && ad.name.isNotEmpty,
              field: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return languageListener.translate("Enter your name");
                  }
                  ad.name = value;
                  nameListener.name = value;
                  return null;
                },
                onChanged: (a) => ad.name = a,
                controller:
                    TextEditingController(text: ad.name ?? nameListener.name),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: languageListener.translate("Name")),
              ),
            ),
            SizedBox(height: padding),
            buildContactMe(),
            Center(
              child: FlatButton(
                child: Text("Preview"),
                textColor: Colors.blue,
                onPressed: () {
                  if (key.currentState.validate())
                    Navigator.pushNamed(context, "/ad", arguments: ad);
                },
              ),
            ),
            RaisedButton(
              colorBrightness: Brightness.dark,
              onPressed: upload,
              child: Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                child: Text(edit
                    ? languageListener.translate("Edit Ad")
                    : languageListener.translate("Upload Ad")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContactMe() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Text(languageListener.translate("Contact me : ")),
          for (var c in ContactMe.values)
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      ad.contactMe = c;
                    });
                  },
                  label: Text(c.toString().split(".").last),
                  icon: Radio<ContactMe>(
                    value: c,
                    onChanged: (s) {
                      setState(() {
                        ad.contactMe = c;
                      });
                    },
                    groupValue: ad.contactMe,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  AspectRatio buildImagesSection() {
    if (images.isEmpty && ad.images.isEmpty)
      return AspectRatio(
        aspectRatio: 2,
        child: Center(
          child: GestureDetector(
            onTap: getImages,
            child: Container(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26),
                ),
                child: Image.asset("assets/images/add_icon.png"),
              ),
            ),
          ),
        ),
      );
    return AspectRatio(
      aspectRatio: 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: 1 + ad.images.length + images.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: .5,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      "assets/images/add_icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: getImages,
                ),
              ),
            );
          } else if (index < ad.images.length + 1) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  ad.images[index - 1],
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  AssetThumb(
                    asset: images[index - ad.images.length - 1],
                    height: 200,
                    width: 200,
                  ),
                  Align(
                    alignment: Alignment(.8, -.8),
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
    // return AspectRatio(
    //   aspectRatio: 2,
    //   child: images == null
    //       ? Material(
    //           child: GestureDetector(
    //             child: Image.asset(
    //               "assets/images/camera.png",
    //               width: 150,
    //               height: 150,
    //               fit: BoxFit.cover,
    //             ),
    //             onTap: getImages,
    //           ),
    //         )
    //       : ListView(scrollDirection: Axis.horizontal, children: [
    //           for (int i = 0; i < images.length; i++)
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Stack(
    //                 fit: StackFit.loose,
    //                 children: <Widget>[
    //                   AssetThumb(
    //                     asset: images[i],
    //                     height: 200,
    //                     width: 200,
    //                   ),
    //                   if (ad.images.length < i + 1)
    //                     Align(
    //                       alignment: Alignment(.8, -.8),
    //                       child: CircularProgressIndicator(),
    //                     ),
    //                 ],
    //               ),
    //             ),
    //           Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(
    //                 color: Colors.black54,
    //                 width: .5,
    //               ),
    //             ),
    //             padding: const EdgeInsets.all(8.0),
    //             child: GestureDetector(
    //               child: Image.asset(
    //                 "assets/images/camera.png",
    //                 fit: BoxFit.cover,
    //               ),
    //               onTap: getImages,
    //             ),
    //           )
    //         ]
    //           // .map((e) => as Widget)
    //           // .toList()
    //           //   ..add
    //           ),
    // );
  }

  void updateCategory() async {
    var c = await showDialog(
      context: context,
      builder: (ctx) => CategorySelectorAlert(
        onSelect: (s) {
          Navigator.pop(ctx, s);
        },
      ),
    );
    setState(() {
      ad.category = c ?? ad.category;
    });
  }

  getImages() async {
    var i = await MultiImagePicker.pickImages(
      maxImages: 8 - (images?.length ?? 0),
      enableCamera: true,
    ).catchError((onError) {});
    if (i != null && i.isNotEmpty) {
      setState(() {
        images.addAll(i);
      });
      for (var img in i) {
        var uri =
            await saveImage(img, "adsImages/${ad.id}/image${img.name}.jpg");
        setState(() {
          ad.images.add(uri.toString());
          images.remove(img);
        });
      }
    }
  }

  Future saveImage(Asset asset, String path) async {
    var byteData = await asset.getByteData(quality: 75);
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = FirebaseStorage.instance.ref().child(path);
    StorageUploadTask uploadTask = ref.putData(imageData);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  void upload() async {
    if (ad.name != cUser.name) {
      cUser.updateName(ad.name);
    }
    if (key.currentState.validate()) {
      if (images.isNotEmpty || ad.images.isEmpty) {
        Toast.show(languageListener.translate("Please upload Images"), context);
      } else {
        ad.date = DateTime.now();
        ad.location = locationListener.location;
        ad.number = cUser.phoneNumber;
        print(ad.toMap());
        await Firestore.instance
            .collection("Ads")
            .document(ad.id)
            .setData(ad.toMap().cast());
        Navigator.pop(context);
      }
    }
  }
}

enum ContactMe { Chat, Phone, Both }

ContactMe contactMeFromString(String c) {
  if (c == ContactMe.Chat.toString()) {
    return ContactMe.Chat;
  } else if (c == ContactMe.Phone.toString()) {
    return ContactMe.Phone;
  } else {
    return ContactMe.Both;
  }
}

// _buildAdditionalDataInput(AdditionalData d) {
//   if (d.values == null || d.values.isEmpty) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: TribleRow(
//         state: d.value != null && (d.value.toString()).isNotEmpty,
//         field: TextFormField(
//           validator: (value) {
//             if (value.isEmpty) {
//               return "Enter ${d.name} ";
//             }
//             return null;
//           },
//           onChanged: (c) {
//             var s;
//             if (d.isDouble) {
//               s = double.parse(c);
//             } else {
//               s = c;
//             }
//             setState(() {
//               d.value = s;
//             });
//           },
//           keyboardType: d.isDouble ? TextInputType.number : null,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//             hintText: d.name,
//             labelText: d.name,
//           ),
//         ),
//       ),
//     );
//   } else {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: TribleRow(
//         state: d.value != null,
//         field: DropdownButton(
//           onChanged: (c) {
//             setState(() {
//               d.value = c;
//             });
//           },
//           value: d.value,
//           items: d.values
//               .map((e) => DropdownMenuItem(
//                     child: Text(e.toString()),
//                     value: e,
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
