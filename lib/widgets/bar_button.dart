import '/constants/constant.dart';
import 'package:flutter/material.dart';

class BarButton extends StatefulWidget {
  BarButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    this.borderColor,
    this.backgroundColor,
    this.radius,
  }) : super(key: key);

  final Function() onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  _BarButtonState createState() => _BarButtonState();
}

class _BarButtonState extends State<BarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    animation = Tween<double>(begin: 1.0, end: 0.85).animate(controller);
    super.initState();
  }

  void onTap() async {
    await controller.forward();
    await controller.reverse();
    widget.onPressed.call();
  }

  void onPanStart(_) {
    controller.reverse();
  }

  onPanDown(_) {
    controller.forward();
  }

  void onPanCancel() async {
    await controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => GestureDetector(
        onTap: onTap,
        onPanStart: onPanStart,
        onPanDown: onPanDown,
        onPanCancel: onPanCancel,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(animation.value),
          child: child,
        ),
      ),
      child: Container(
        width: widget.width ?? 60.0,
        height: widget.height ?? 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
          border: Border.all(
              width: 4.0, color: widget.borderColor ?? Color(0xff1d1d1d)),
          color: widget.backgroundColor ?? CustomColors.scaffoldBackground,
        ),
        child: widget.child,
      ),
    );
  }
}
