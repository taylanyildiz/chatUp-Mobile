import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  CustomBottomNav({
    Key? key,
    required this.onPress,
    required this.items,
    this.color,
    this.selectColor,
    this.height,
    this.initialIndex = 0,
  }) : super(key: key);

  final List<CustomBarItem> items;
  final Function(int) onPress;
  final Color? selectColor;
  final Color? color;
  final double? height;
  final int initialIndex;

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  void onSelect(int index) {
    selectedIndex = index;
    widget.onPress.call(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 70.0,
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.items.length,
          (index) => GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: widget.initialIndex == index
                    ? Colors.white
                    : Colors.transparent,
              ),
              child: Center(
                child: Icon(
                  widget.items[index].icon,
                  color: widget.initialIndex == index
                      ? widget.selectColor
                      : widget.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBarItem {
  CustomBarItem(this.icon, {this.label});
  final IconData icon;
  final String? label;
}
