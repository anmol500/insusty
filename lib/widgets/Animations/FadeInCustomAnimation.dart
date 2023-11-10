import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInCustomAnimation extends StatefulWidget {
  final Widget child;

  FadeInCustomAnimation({required this.child});

  @override
  _FadeInCustomAnimationState createState() => _FadeInCustomAnimationState();
}

class _FadeInCustomAnimationState extends State<FadeInCustomAnimation> {
  bool _isVisible = false;
  final GlobalKey _visibilityKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (visibilityInfo) async {
        if (visibilityInfo.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 800), // Adjust the duration as needed
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
