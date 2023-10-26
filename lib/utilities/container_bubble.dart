import 'package:flutter/material.dart';

class ContainerBubble extends StatelessWidget {
  Widget childWidget;

  ContainerBubble({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black38,
      ),
      child: childWidget,
    );
  }
}
