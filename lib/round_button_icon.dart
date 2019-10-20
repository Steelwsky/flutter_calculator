import 'package:flutter/material.dart';

class RoundButtonIcon extends StatelessWidget {
  final IconData icon;
  final Color clrBackground;
  final Color clrFonts;
  final Size size = Size(80.0, 80.0);
  final Function func;
  final String str;

  RoundButtonIcon(this.str, this.icon, this.clrBackground, this.clrFonts, this.func);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(size),
          onPressed: () {
            func(str);
          },
          child: new Icon(
            this.icon,
            color: this.clrFonts,
            size: 26,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: this.clrBackground,
          padding: const EdgeInsets.all(0.0),
        ));
  }
}
