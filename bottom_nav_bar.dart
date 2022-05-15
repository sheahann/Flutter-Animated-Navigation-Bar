import 'package:flutter/material.dart';

enum NavBarTitleType { always, never }

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
    required this.icons,
    this.borderRadius = 20,
    required this.activeColor,
    required this.inactiveColor,
    this.titles,
    this.iconSize = 24,
    this.iconTitleSize = 13,
    this.animationRange = 4,
    this.backgroundColor = Colors.white,
    this.titleType = NavBarTitleType.never,
    required this.onChange,
  }) {
    if (titleType == NavBarTitleType.always) {
      assert(titles != null && titles!.length == icons.length);
    }
  }

  final List<IconData> icons;
  final List<String>? titles;
  final double? borderRadius;
  final Color activeColor;
  final Color inactiveColor;
  final double? iconSize;
  final double? iconTitleSize;
  final double? animationRange;
  final Color? backgroundColor;
  final NavBarTitleType? titleType;
  final Function(int callback) onChange;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int currentSelected = 0;
  late AnimationController _animationController;
  late Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _sizeAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.iconSize,
          end: widget.iconSize! - widget.animationRange!,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.iconSize! - widget.animationRange!,
          end: widget.iconSize,
        ),
        weight: 1,
      ),
    ]).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      //height: screenHeight * 0.08,
      width: screenWidth * widget.icons.length * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius!),
        color: widget.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          widget.icons.length,
          (index) => InkWell(
            onTap: () {
              _animationController.reset();
              _animationController.forward();
              currentSelected = index;
              widget.onChange(currentSelected);
              setState(() {});
            },
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  widget.icons[index],
                  color: currentSelected == index
                      ? widget.activeColor
                      : widget.inactiveColor,
                  size: currentSelected == index
                      ? _sizeAnimation.value
                      : widget.iconSize,
                ),
                Visibility(
                  visible:
                      widget.titleType == NavBarTitleType.always ? true : false,
                  child: Text(
                    widget.titleType == NavBarTitleType.always
                        ? widget.titles![index]
                        : "",
                    style: TextStyle(
                      color: currentSelected == index
                          ? widget.activeColor
                          : widget.inactiveColor,
                      fontSize: widget.iconTitleSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
