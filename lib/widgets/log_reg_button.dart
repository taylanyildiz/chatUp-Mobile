import '/constants/constant.dart';
import 'package:flutter/material.dart';

class LogRegButton extends StatefulWidget {
  LogRegButton({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  final Function() onLogin;
  final Function() onRegister;

  @override
  _LogRegButtonState createState() => _LogRegButtonState();
}

class _LogRegButtonState extends State<LogRegButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInCirc,
      reverseCurve: Curves.easeInCirc,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void onRegister() async {
    if (!controller.isAnimating) {
      await controller.reverse();
      widget.onRegister.call();
    }
  }

  void onSignIn() async {
    if (!controller.isAnimating) {
      await controller.forward();
      widget.onLogin.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: CustomColors.hintColor),
      width: size.width,
      child: Stack(
        children: [
          Positioned(
            left: ((size.width - 40) / 2) * animation.value,
            top: 0.0,
            bottom: 0.0,
            right: (size.width - 40) / 2 * (1 - animation.value),
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onRegister,
                  child: Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.value < .5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onSignIn,
                  child: Container(
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.value >= .5
                              ? Colors.black
                              : Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
