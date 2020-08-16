import 'package:flutter/material.dart';

class StateTile extends StatelessWidget {
  final bool state;
  final Widget child;

  const StateTile({Key key, this.child, this.state = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 15,
        height: 15,
        child: child,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: state ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
