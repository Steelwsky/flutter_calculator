import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String str;
  final Color clrBackground;
  final Color clrFonts;
  final Size size = Size(80.0, 80.0);

  RoundButton(this.str, this.clrBackground, this.clrFonts);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(size),
          onPressed: () {},
          child: new Text(
            "$str",
            style: TextStyle(
                fontSize: 36, color: clrFonts, fontWeight: FontWeight.w500),
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: this.clrBackground,
          padding: const EdgeInsets.all(0.0),
        ));
  }
}
