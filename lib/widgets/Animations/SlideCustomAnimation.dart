import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

// right to left

import 'package:flutter/cupertino.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SlideInFromLeftOnVisible extends StatefulWidget {
  final Widget child;

  SlideInFromLeftOnVisible({required this.child});

  @override
  _SlideInFromLeftOnVisibleState createState() => _SlideInFromLeftOnVisibleState();
}

class _SlideInFromLeftOnVisibleState extends State<SlideInFromLeftOnVisible> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Cancel the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('slideInFromLeftKey'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2 && !_isVisible) {
          _controller.forward();
        }
      },
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-2.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

// right to left

class SlideInFromRightOnVisible extends StatefulWidget {
  final Widget child;

  SlideInFromRightOnVisible({required this.child});

  @override
  _SlideInFromRightOnVisibleState createState() => _SlideInFromRightOnVisibleState();
}

class _SlideInFromRightOnVisibleState extends State<SlideInFromRightOnVisible> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('slideInFromRightKey'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2 && !_isVisible) {
          _controller.forward();
        }
      },
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(2.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
