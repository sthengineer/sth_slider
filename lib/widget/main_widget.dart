import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sth_slider/model/ruler_model.dart';
import 'package:sth_slider/widget/line_widget.dart';

class MainWidget extends StatefulWidget {
  final Widget? title;
  final Widget? scale;
  final Widget? child;
  final Color? unselectedColor;
  final Color? selectedColor;
  final Function(String)? getData;
  final String fontFamily;
  final BoxDecoration? boxDecoration;

  const MainWidget({
    Key? key,
    this.title,
    this.scale,
    this.getData,
    this.child,
    this.unselectedColor,
    this.selectedColor,
    required this.fontFamily,
    this.boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(0)),
    ),
  }) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final List<RulerModel> _lineList = <RulerModel>[];
  final PageController _controller =
      PageController(initialPage: 6, viewportFraction: 0.08);
  int currentIndex = 0;

  void _createList() {
    for (int i = 10; i <= 70; i++) {
      if (i == 16) {
        _lineList.add(RulerModel(index: i, isSelected: true));
      }
      _lineList.add(RulerModel(index: i, isSelected: false));
    }
  }

  void onChange(int page) {
    for (var element in _lineList) {
      element.isSelected = false;
    }
    _lineList[currentIndex].isSelected = true;
    HapticFeedback.vibrate();
    widget.getData!(_lineList[currentIndex].index.toString());
    //Todo get index of selected here
  }

  @override
  void initState() {
    super.initState();
    _createList();
    _controller.addListener(() {
      if (_controller.page!.round() != currentIndex) {
        setState(() {
          currentIndex = _controller.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: widget.boxDecoration,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title ?? Container(),
                    widget.scale ?? Container()
                  ],
                ),
                SizedBox(
                  height: 130,
                  child: PageView.builder(
                    reverse: true,
                    itemCount: _lineList.length,
                    controller: _controller,
                    onPageChanged: onChange,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return LineWidget(
                        item: _lineList[itemIndex],
                        font: widget.fontFamily,
                        child: widget.child,
                        selectedColor: widget.selectedColor,
                        unselectedColor: widget.unselectedColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
