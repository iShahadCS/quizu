import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  const CircleButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          color: Color(0xff7956f4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
