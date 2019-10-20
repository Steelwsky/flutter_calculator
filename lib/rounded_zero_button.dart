import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZeroButton extends StatelessWidget {
  final String str;
  final Color clrBackground;
  final Color clrFonts;
  final Size size = Size(168.0, 80.0);
  final Function func;

  ZeroButton(this.str, this.clrBackground, this.clrFonts, this.func);

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
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 36, color: clrFonts, fontWeight: FontWeight.w500),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
          elevation: 2.0,
          fillColor: this.clrBackground,
          padding: const EdgeInsets.only(right: 84),
        ));
  }
}
