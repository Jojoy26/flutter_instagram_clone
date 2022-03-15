import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {

  final Widget child;
  final void Function() onTap;

  const LikeAnimation({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with TickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scale = Tween(begin: 1.0, end: 1.2).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: InkWell(
        onTap: () async{
          widget.onTap();
          await controller.forward();
          await controller.reverse();
        },
        child: Padding(
          padding: EdgeInsets.all(7),
          child: widget.child,
        ),
      ),
    );
  }
}