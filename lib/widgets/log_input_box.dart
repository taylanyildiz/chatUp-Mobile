import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';

class LogInputBox extends StatefulWidget {
  LogInputBox({
    Key? key,
    required this.suffixIcon,
    this.textController,
    this.type = TextInputType.name,
    this.height,
    this.width,
    this.padding,
    this.hint,
    this.isPassword = false,
    this.maxLine = 15,
  }) : super(key: key);

  final TextEditingController? textController;
  final TextInputType? type;
  final String? hint;
  final double? height;
  final double? width;
  final bool isPassword;
  final double? padding;
  final IconData suffixIcon;
  final int maxLine;

  @override
  _LogInputBoxState createState() => _LogInputBoxState();
}

class _LogInputBoxState extends State<LogInputBox> {
  bool isVisible = true;
  bool isEmpty = true;

  _onChanged(String? input) {
    if (input!.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }
    setState(() {});
  }

  _onVisible() {
    isVisible = !isVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.padding ?? 0.0,
        right: widget.padding ?? 0.0,
        top: 15.0,
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          validator: (input) {
            if (input!.isEmpty) return "";
          },
          keyboardType: widget.type,
          obscureText: !widget.isPassword ? widget.isPassword : isVisible,
          controller: widget.textController,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
          onChanged: _onChanged,
          maxLength: widget.maxLine,
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: CustomColors.hintColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              counterText: "",
              errorText: "",
              errorStyle: TextStyle(fontSize: 0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: CustomColors.borderColor,
                  width: 3.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: CustomColors.borderColor,
                  width: 3.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: CustomColors.borderColor,
                  width: 3.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: CustomColors.borderColor,
                  width: 3.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: CustomColors.borderColor,
                  width: 3.0,
                ),
              ),
              prefixIcon: Icon(
                widget.suffixIcon,
                color: CustomColors.hintColor,
              ),
              suffixIcon: widget.isPassword
                  ? Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        onPressed: _onVisible,
                        icon: Icon(
                          !isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        color: CustomColors.hintColor,
                      ),
                    )
                  : SizedBox.shrink()),
        ),
      ),
    );
  }
}
