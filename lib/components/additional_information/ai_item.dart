import 'package:flutter/material.dart';

class AIItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;

  const AIItem(
      {Key? key, required this.icon, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
