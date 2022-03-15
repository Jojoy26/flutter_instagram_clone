import 'package:flutter/material.dart';

class ImageAnimation extends StatefulWidget {

  final Widget child;
  final void Function() onTap;

  const ImageAnimation({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ImageAnimation> createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation> with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;

  Future<void> callAnimation() async {
    await controller.forward();
    await controller.reverse();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scale = Tween(begin: 1.0, end: 1.2).animate(controller);
    opacity = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: ScaleTransition(
        scale: scale,
        child: GestureDetector(
          onDoubleTap: (){
            widget.onTap();
            callAnimation();
          },
          child: widget.child,
        ),
      ),
    );
  }
}