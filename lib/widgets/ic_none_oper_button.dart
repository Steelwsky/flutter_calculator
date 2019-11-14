import 'package:flutter/material.dart';

class NoOperatorButton extends StatelessWidget {
  NoOperatorButton(this._icon, this._clrBackground, this._clrFonts, this._func);
  final IconData _icon;
  final Color _clrBackground;
  final Color _clrFonts;
  final Size _size = Size(80.0, 80.0);
  final Function _func;

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(_size),
          onPressed: () {
            _func();
          },
          child: new Icon(
            this._icon,
            color: this._clrFonts,
            size: 26,
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: this._clrBackground,
          padding: const EdgeInsets.all(0.0),
        ));
  }
}

