import 'dart:math';

import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';

class SignButton extends StatefulWidget {
  SignButton({
    Key? key,
    required this.onTap,
    required this.controller,
    required this.child,
    this.height = 40.0,
    this.width = 100.0,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Function() onTap;
  final SingButtonController controller;
  final Widget child;
  final double height;
  final double width;
  final Color? backgroundColor;

  @override
  _SignButtonState createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> with TickerProviderStateMixin {
  late AnimationController controllerScale;
  late AnimationController controllerLoading;
  late Animation<double> animationScale;
  late Animation<double> animOp;

  @override
  void initState() {
    controllerScale = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    controllerLoading = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animationScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: controllerScale,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });
    animOp = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controllerLoading,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });

    widget.controller._addListener(() => controllerLoading.reverse());
    super.initState();
  }

  onTap() async {
    await controllerScale.forward();
    await controllerScale.reverse();
    await controllerLoading.forward();

    widget.onTap.call();
  }

  onPanDown(_) async {
    await controllerScale.forward();
  }

  onPanStart(_) async {
    await controllerScale.reverse();
  }

  onPanCancel() async {
    await controllerScale.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(animationScale.value),
      child: GestureDetector(
        onTap: onTap,
        onPanDown: onPanDown,
        onPanStart: onPanStart,
        onPanCancel: onPanCancel,
        child: ShaderMask(
          shaderCallback: (rect) => RadialGradient(
            radius: 10 * (1 - animOp.value),
            colors: [
              Colors.green,
              Colors.green,
              Colors.green,
              Colors.green,
              widget.backgroundColor ?? Colors.white,
            ],
            center: FractionalOffset(0.0, 0.5),
          ).createShader(rect),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                min(widget.width, widget.height) / 4,
              ),
              color: widget.backgroundColor,
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: animOp.value,
                    child: widget.child,
                  ),
                  Opacity(
                    opacity: 1 - animOp.value,
                    child: SizedBox(
                        width: widget.height / 2,
                        height: widget.height / 2,
                        child: CircularProgressIndicator(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SingButtonController {
  late Function() _stop;
  _addListener(Function() stop) {
    this._stop = stop;
  }

  void stop() => _stop();
}
