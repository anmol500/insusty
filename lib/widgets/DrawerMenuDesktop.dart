import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrawerMenuDesktop extends StatefulWidget {
  final String name;
  final Function onTap;
  final IconData? icon;
  final bool isActive;

  const DrawerMenuDesktop({
    Key? key,
    required this.name,
    required this.onTap,
    this.icon,
    required this.isActive,
  }) : super(key: key);

  @override
  _DrawerMenuDesktopState createState() => _DrawerMenuDesktopState();
}

class _DrawerMenuDesktopState extends State<DrawerMenuDesktop> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _lineAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant DrawerMenuDesktop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.icon == null
                    ? Container()
                    : Column(
                        children: [
                          Icon(
                            widget.icon,
                            size: 28,
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                Container(
                  width: 120, // Adjust this value
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: widget.isActive ? Color(0xff000903) : Color(0xff00370F),
                      fontSize: 20,
                      fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            3.height,
            AnimatedBuilder(
              animation: _lineAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(50 * (1 - _lineAnimation.value), 0), // 50 is half of the width
                  child: Container(
                    alignment: Alignment.center,
                    width: 120 * _lineAnimation.value, // Match with the above value
                    height: 2,
                    color: widget.isActive ? Color(0xff014f16) : Colors.transparent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
