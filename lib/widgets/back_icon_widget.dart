import 'package:flutter/material.dart';

class BackIconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  const BackIconWidget({
    Key? key,
    this.icon = Icons.arrow_back,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
