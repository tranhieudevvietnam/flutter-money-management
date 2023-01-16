import 'package:flutter/material.dart';
import 'dart:math';

class DropUIWidget extends StatefulWidget {
  final Widget childTitle;
  final Widget childBody;
  const DropUIWidget(
      {super.key, required this.childTitle, required this.childBody});

  @override
  State<DropUIWidget> createState() => _DropUIWidgetState();
}

class _DropUIWidgetState extends State<DropUIWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus status;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        this.status = status;
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: Column(
        children: [
          widget.childTitle,
          AnimatedBody(
            animation: animation,
            child: widget.childBody,
          )
        ],
      )),
      GestureDetector(
        onTap: () {
          if (status == AnimationStatus.completed) {
            controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
          }
        },
        child: Transform.rotate(
          angle: pi / 90.0,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Icon(
              Icons.arrow_drop_down_outlined,
            ),
          ),
        ),
      ),
    ]);
  }
}

class AnimatedBody extends AnimatedWidget {
  final Widget child;
  const AnimatedBody(
      {super.key, required this.child, required Animation<double> animation})
      : super(listenable: animation);

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.0, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 50);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    );
  }
}
