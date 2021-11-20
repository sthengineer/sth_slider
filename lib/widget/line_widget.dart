import 'package:flutter/material.dart';
import 'package:sth_slider/model/ruler_model.dart';

class LineWidget extends StatefulWidget {
  final RulerModel item;
  final Color? selectedColor;
  final Color? unselectedColor;
  final String? font;
  final Widget? child;

  const LineWidget({
    Key? key,
    required this.item,
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.grey,
    this.font = 'Arial',
    this.child,
  }) : super(key: key);

  @override
  _LineWidgetState createState() => _LineWidgetState();
}

class _LineWidgetState extends State<LineWidget> {
  static String checkDouble(String str) {
    while ((str.contains('.') && str.endsWith('0')) || str.endsWith('.')) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  bool _isFifth(int index) {
    double surplus = index / 5;
    bool _fifth = false;
    if (checkDouble(surplus.toString()).contains('.')) {
      _fifth = false;
    } else {
      _fifth = true;
    }
    return _fifth;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3, left: 3),
      child: widget.child ?? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _isFifth(widget.item.index)
                    ? FittedBox(
                        child: Text(
                          widget.item.index.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: widget.font,
                            color: widget.item.isSelected
                                ? widget.selectedColor
                                : widget.unselectedColor,
                          ),
                        ),
                      )
                    : widget.item.isSelected
                        ? FittedBox(
                            child: Text(
                              widget.item.index.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: widget.font,
                                color: widget.item.isSelected
                                    ? widget.selectedColor
                                    : widget.unselectedColor,
                              ),
                            ),
                          )
                        : Container(),
                const SizedBox(height: 5),
                Container(
                  width: 3,
                  height: _isFifth(widget.item.index) == false
                      ? widget.item.isSelected
                          ? 30
                          : 20
                      : widget.item.isSelected
                          ? 50
                          : 40,
                  color: widget.item.isSelected
                      ? widget.selectedColor
                      : widget.unselectedColor,
                ),
                widget.item.isSelected
                    ? Container()
                    : const SizedBox(height: 10)
              ],
            ),
    );
  }
}
