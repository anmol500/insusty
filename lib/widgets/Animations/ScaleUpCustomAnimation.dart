import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScaleUpCustomAnimation extends StatefulWidget {
  final Widget child;

  ScaleUpCustomAnimation({required this.child});

  @override
  _ScaleUpCustomAnimationState createState() => _ScaleUpCustomAnimationState();
}

class _ScaleUpCustomAnimationState extends State<ScaleUpCustomAnimation> {
  bool _isVisible = false;
  final GlobalKey _visibilityKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction >= 0.2 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: AnimatedScale(
        duration: Duration(milliseconds: 600), // Adjust the duration as needed
        curve: Curves.easeOut,
        scale: _isVisible ? 1.0 : 0.0,
        child: widget.child,
      ),
    );
  }
}
