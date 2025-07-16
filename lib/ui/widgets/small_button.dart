import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClick;

  const SmallButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onClick,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}