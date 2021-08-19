import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';

class SearchListView extends StatefulWidget {
  SearchListView({
    Key? key,
    required this.itemCount,
    this.serchHeight = 50.0,
    this.hint = 'Search',
    required this.builder,
  }) : super(key: key);

  final double serchHeight;
  final int itemCount;
  final String? hint;
  final Widget Function(BuildContext context, int index) builder;
  @override
  _SearchListViewState createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  late ScrollController scrollController;
  double opacity = 0;
  double anim = 1.0;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  bool onNotification(scrollState) {
    if (scrollState is ScrollEndNotification &&
        (scrollState.metrics.pixels >= 0 &&
            scrollState.metrics.pixels < widget.serchHeight / 2)) {
      Future.delayed(const Duration(milliseconds: 100), () {}).then((s) {
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      });
    }
    if (scrollState is ScrollEndNotification &&
        (scrollState.metrics.pixels >= widget.serchHeight / 2 &&
            scrollState.metrics.pixels <= widget.serchHeight)) {
      Future.delayed(const Duration(milliseconds: 100), () {}).then((s) {
        scrollController.animateTo(50,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      });
    }
    return false;
  }

  double getPosition(double height, int index, int totalCount) {
    if (scrollController.hasClients) {
      final itemPositionOffset = totalCount * index;
      final difference = scrollController.offset - itemPositionOffset;
      final percent = 1 - (difference / height);
      anim = percent;
      if (percent > 1.0) anim = 1.0;
      if (percent <= 0.0) anim = 0.0;
    }
    return anim;
  }

  double get searchOpacity => getPosition(
        widget.serchHeight / 2,
        0,
        widget.itemCount,
      );

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          itemCount: widget.itemCount + 1,
          itemBuilder: (context, index) {
            if (index == 0)
              return _SearchBox(
                opacity: searchOpacity,
                hint: widget.hint,
              );
            return widget.builder(context, index - 1);
          },
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  _SearchBox({
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
          horizontal: padding ?? 20.0,
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
