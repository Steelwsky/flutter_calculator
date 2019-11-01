import 'package:flutter/material.dart';

class StringButton extends StatelessWidget {
  final String str;
  final Color clrBackground;
  final Color clrFonts;
  final Size size = Size(80.0, 80.0);
  final Function func;

  StringButton(this.str, this.clrBackground, this.clrFonts, this.func);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(size),
          onPressed: () {
            func(str);
          },
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
