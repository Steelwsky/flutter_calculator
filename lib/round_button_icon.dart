import 'package:flutter/material.dart';

class RoundButtonIcon extends StatelessWidget {
  final IconData icon;
  final Color clrBackground;
  final Color clrFonts;
  final Size size = Size(80.0, 80.0);

  RoundButtonIcon(this.icon, this.clrBackground, this.clrFonts);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(size),
          onPressed: () {},
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
