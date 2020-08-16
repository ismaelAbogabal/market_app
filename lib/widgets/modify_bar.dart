import 'package:flutter/material.dart';
import 'package:market/screens/filter_screen.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/filter.dart';

class ModifyBar extends StatelessWidget {
  final Function(Filter) onFiltered;
  final Function oOrder;
  final Filter filter;

  const ModifyBar({Key key, this.filter, this.onFiltered, this.oOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        elevation: 12,
        child: Row(
          children: <Widget>[
            Expanded(
              child: FittedBox(
                fit: BoxFit.fill,
                child: FlatButton.icon(
                  icon: Image.asset(
                    "assets/images/filter.png",
                    width: 15,
                    height: 15,
                  ),
                  label: Text(languageListener.translate("Filter")),
                  onPressed: () => getFilter(context),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 30,
              color: Colors.black12,
            ),
            Expanded(
              child: PopupMenuButton<Order>(
                onSelected: (value) {
                  onFiltered(filter..order = value);
                },
                child: Text(languageListener.translate("Order"),
                    textAlign: TextAlign.center),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: Order.date,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(languageListener.translate("Date")),
                        Icon(
                          Icons.check_circle,
                          color: filter.order != Order.date
                              ? Colors.black12
                              : Colors.green,
                        ),
                      ],
                    ),
                    enabled: filter.order != Order.date,
                  ),
                  PopupMenuItem(
                    value: Order.priceLTH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(languageListener.translate("Price low to high")),
                        Icon(
                          Icons.check_circle,
                          color: filter.order != Order.priceLTH
                              ? Colors.black12
                              : Colors.green,
                        ),
                      ],
                    ),
                    enabled: filter.order != Order.priceLTH,
                  ),
                  PopupMenuItem(
                    value: Order.priceHTL,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(languageListener.translate("Price high to low")),
                        Icon(
                          Icons.check_circle,
                          color: filter.order != Order.priceHTL
                              ? Colors.black12
                              : Colors.green,
                        ),
                      ],
                    ),
                    enabled: filter.order != Order.priceHTL,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 30,
              color: Colors.black12,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.fill,
                child: FlatButton.icon(
                  icon: Icon(Icons.save),
                  label: Text(languageListener.translate("Save")),
                  onPressed: () => FavoriteUtils.addFilter(filter),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getFilter(BuildContext context) async {
    Filter f = await showDialog(
      context: context,
      builder: (context) {
        return FilterScreen(filter: filter);
      },
    );

    if (f != null && onFiltered != null) {
      onFiltered(f);
    }
  }
}
