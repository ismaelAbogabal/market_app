import 'package:flutter/material.dart';

class TripleRow extends StatelessWidget {
  final bool state;
  final Widget field;
  final Widget icon;
  final Function() onRemove;

  const TripleRow({
    Key key,
    this.state = false,
    this.icon,
    this.onRemove,
    @required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                  child: icon,
                  fit: BoxFit.contain,
                ),
              ),
              radius: 10,
              backgroundColor: state ? Colors.green : Colors.grey,
            ),
          ),
          Expanded(
            child: field,
          ),
          if (onRemove != null && state)
            IconButton(
              icon: Icon(Icons.close ,color: Colors.black54),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
