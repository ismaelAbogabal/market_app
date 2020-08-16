import 'package:flutter/material.dart';
import 'package:market/screens/add_ad_screen.dart';
import 'package:market/screens/images_screen.dart';
import 'package:market/screens/user_ads_list.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/admob_ad.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/user.dart';
import 'package:market/widgets/fab.dart';
import 'package:market/widgets/favorite_star.dart';
import 'package:toast/toast.dart';

import '../utils/chat.dart';
import '../utils/message.dart';

class AdScreen extends StatelessWidget {
  final PageController controller = PageController();

  AdScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ad ad = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButton: ad.contactMe != ContactMe.Chat ? FAB(ad: ad) : null,
      bottomNavigationBar: (ad.contactMe == ContactMe.Phone)
          ? null
          : Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      textColor: Colors.red,
                      child: Text(languageListener.translate("place an order")),
                      onPressed: () => sendMessage(ad, context, true),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      textColor: Colors.blue,
                      child: Text(languageListener.translate("Send message")),
                      onPressed: () => sendMessage(ad, context),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: .5,
                  ),
                ),
              ),
            ),
      body: CustomScrollView(
        slivers: <Widget>[
          buildSliverAppBar(context, ad),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.location_on, color: Colors.red),
                        title: Text(languageListener.translate("Location")),
                        trailing: Text(
                          ad.location?.translatedLast ??
                              languageListener.translate("location"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Divider(),
                      ListTile(
                          title: Text(languageListener.translate("About"))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(ad.description,
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "\n ${ad.name}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text(languageListener.translate("All user ads")),
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserAdsList(
                              name: ad.name,
                              userId: ad.userId,
                            ),
                          ));
                    },
                  ),
                ),
                buildAdMobAd(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(languageListener.safetyRules),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAdMobAd() {
    return AdMobAds.ad ?? Text("");
  }

  SliverAppBar buildSliverAppBar(BuildContext context, Ad ad) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(ad.title),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
              onTap: () => openImagePage(context, ad),
              child: Hero(
                tag: ad.images.first,
                child: PageView.builder(
                  itemCount: ad.images.length,
                  itemBuilder: (context, index) => Image.network(
                    ad.images[index],
                    fit: BoxFit.cover,
                  ),
                  controller: controller,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black12,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${ad.price}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Divider(color: Colors.white),
                    Text(
                      formatDate(ad.date),
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(color: Colors.white),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: FavoriteStar(
                        ad: ad,
                        color: Colors.white12,
                        activeColor: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final TextEditingController messageController = TextEditingController();

  void sendMessage(Ad ad, BuildContext context, [bool order = false]) async {
    if (cUser == null) {
      Navigator.pushNamed(context, "/login");
      Future.delayed(Duration(seconds: 1), () {
        Toast.show(languageListener.translate("Please log in first"), context);
      });
      return;
    }
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FittedBox(
              child: Text(
                order
                    ? languageListener.weWillWrite
                    : languageListener.safetyRules,
              ),
            ),
            TextField(
              autofocus: true,
              controller: messageController,
              keyboardType: order ? TextInputType.number : null,
              decoration: InputDecoration(
                hintText: order
                    ? languageListener.iWillPay
                    : languageListener.translate("Message"),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Send"),
            onPressed: () {
              if (order) {
                double x = double.tryParse(messageController.text);
                if (x != null && messageController.text != null)
                  Navigator.pop(context);
              } else if (messageController.text.isNotEmpty)
                Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              messageController.text = "";
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    if (messageController.text.isEmpty) return;
    if (order && double.tryParse(messageController.text) == null) return;
    if (cUser.uid == ad.userId) {
      Toast.show("cant send message to your self", context);
      return;
    }

    Chat c = await Chat.withUser(ad.userId);

    if (c == null) {
      c = Chat(
        ad: ad,
        other: ad.userId,
      );
      await c.createChat();
    }

    String message = order
        ? "اود ان اقدم عرض  ب" +
            double.tryParse(messageController.text).toString()
        : messageController.text;

    await c.sendMessage(
      Message(text: message),
      (await User.getTokens(c.other)),
    );

    messageController.text = "";
  }

  void openImagePage(BuildContext context, Ad ad) {
    showDialog(
      context: context,
      builder: (context) => ImagesScreen(
        current: controller.page.floor(),
        images: ad.images,
      ),
    );
  }
}
