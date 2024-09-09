import 'package:flutter/material.dart';

class Mybutton extends StatefulWidget {
  final String txt;
  final void Function()? onTap;
  final Color? color;
  final double? height;
  final double? width;
  const Mybutton(
      {super.key,
      required this.txt,
      required this.onTap,
      this.color,
      this.height,
      this.width});

  @override
  State<Mybutton> createState() => _MybuttonState();
}

class _MybuttonState extends State<Mybutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      // splashColor: Colors.green,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              color: Theme.of(context).colorScheme.primary)
        ], color: widget.color, borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            widget.txt,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
