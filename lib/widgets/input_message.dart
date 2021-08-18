import 'dart:developer';

import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputMessage extends StatefulWidget {
  InputMessage({
    Key? key,
    TextEditingController? textController,
    this.onChanded,
    required this.onSend,
    required this.onAdd,
    this.padding,
    this.radius,
  })  : this.textController = textController ?? TextEditingController(),
        super(key: key);

  final TextEditingController textController;
  final Function(String) onSend;
  final Function() onAdd;
  final Function(String?)? onChanded;
  final double? padding;
  final double? radius;

  @override
  _InputMessageState createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  late String message;

  void onSend() {
    if (widget.textController.text.isNotEmpty) {
      message = widget.textController.text;
      widget.onSend.call(message);
      widget.textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(
          horizontal: widget.padding ?? 20.0, vertical: 10.0),
      child: Stack(
        children: [
          SizedBox(
            height: 60.0,
            child: TextField(
              controller: widget.textController,
              onChanged: widget.onChanded,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 5.0,
                  right: 50.0,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                prefixIcon: Container(
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: CustomColors.borderColor.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: CustomColors.hintColor,
                      size: 20.0,
                    ),
                    onPressed: widget.onAdd,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: InkWell(
              onTap: onSend,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.unReadBox,
                ),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.paperPlane,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
