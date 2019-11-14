import 'package:flutter/material.dart';

class StringButton extends StatelessWidget {
  final String _str;
  final Color _clrBackground;
  final Color _clrFonts;
  final Size _size = Size(80.0, 80.0);
  final Function _func;

  StringButton(this._str, this._clrBackground, this._clrFonts, this._func);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(_size),
          onPressed: () {
//            if (str != null) func(str);
//            func();
          _func(_str);
          },
          child: new Text(
            "$_str",
            style: TextStyle(
                fontSize: 36, color: _clrFonts, fontWeight: FontWeight.w500),
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: this._clrBackground,
          padding: const EdgeInsets.all(0.0),
        ));
  }
}
