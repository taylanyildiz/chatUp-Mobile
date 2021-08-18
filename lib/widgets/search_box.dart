import '/constants/constant.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  SearchBox({
    Key? key,
    required this.opacity,
    this.hint,
    this.padding,
    this.backgroundColor,
    this.height,
    this.radius,
  }) : super(key: key);

  final double opacity;
  final String? hint;
  final double? padding;
  final double? height;
  final double? radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: height ?? 50.0,
      color: CustomColors.chatBox,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding ?? 10.0,
          vertical: 5.0,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? CustomColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(radius ?? 10.0),
              ),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(1.0, opacity),
              child: Opacity(
                opacity: opacity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: hint ?? 'Search',
                    hintStyle: TextStyle(
                      color: CustomColors.hintColor,
                    ),
                    filled: true,
                    fillColor: CustomColors.scaffoldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: EdgeInsets.only(top: 5.0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: CustomColors.hintColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
