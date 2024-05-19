import 'package:flutter/material.dart';

class CircularButtonWithTitle extends StatelessWidget {
  const CircularButtonWithTitle({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.onPressed,
    required this.icon,
  });
  final String title;
  final Icon icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor,
            radius: MediaQuery.of(context).size.width * 0.1,
            child: icon,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black, shadows: [
              Shadow(
                color: Colors.black45,
                blurRadius: 7,
              )
            ]),
          )
        ],
      ),
    );
  }
}
