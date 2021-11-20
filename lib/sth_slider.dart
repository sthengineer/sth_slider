library sth_slider;

import 'package:flutter/material.dart';
import 'package:sth_slider/widget/main_widget.dart';

class SthSlider extends StatelessWidget {
  final String fontFamily;
  final Color? unselectedColor;
  final Color? selectedColor;
  final Widget? child;
  final Widget? title;
  final Widget? scale;
  final BoxDecoration boxDecoration;
  final Function(String) getData;

  const SthSlider({
    Key? key,
    required this.fontFamily,
    this.unselectedColor,
    this.selectedColor,
    this.child,
    this.title,
    this.scale,
    required this.boxDecoration,
    required this.getData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MainWidget(
        fontFamily: fontFamily,
        unselectedColor: unselectedColor,
        selectedColor: selectedColor,
        child: child,
        title: title,
        scale: scale,
        boxDecoration: boxDecoration,
        getData: getData,
      ),
    );
  }
}
